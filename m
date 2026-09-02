Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6444CCDC8;
	Wed,  2 Sep 2026 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307588; cv=none; b=VN8bEfFAiiz3FtYw9gUxKhFUVTQBHAPOPSznby9mnIuJsA+pQtkB0zGZKQl2otx7HC2AfvhsOPQL7UcpEvTf+IjRO0arTmg8MoqcH0tETnssD6fVKTz+IWjVdFvbU1ha9JwZuE4tHYI4C7ApxmMghGogC96GVtDdyntgYI93dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307588; c=relaxed/simple;
	bh=Iv6FaRMec72KrM0qMjHuaCvV0ci6HW6mDs8+K12cRKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owblPx+0O3oOjcFpjj9AWBp0ocOBg0h8jXYy6pmfZAJZaQlJFrHmf2Mrah2qVhYtdST7RO5OQAHU9f/OB9pNPn0LliTK6qgkn6DKFkyL8kQ2s/69S2CVgPSVcC6A21O864Mv/fRwata+sEqgjVV/9zNKwz0V9ozN6lMAQ3iTzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfBpnTrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfBpnTrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F7E1F000E9;
	Wed,  2 Sep 2026 00:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788307587;
	bh=IMkjSu6Ae8X36Z+stIGdRfyftVUmf4pE1/8+z8IXJjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bfBpnTrRQeJ4tk/09rFl2iGm4HtyqyoLBRBblzeb9iTRLrji1t7nmNawJMNBnUHvU
	 c/MDpUlEK5tTE1f+xmOYkDb5fUebd+Rumljj9/mhDZ8tIHBngkOiOwODpknnNm/xlm
	 PdLfHr/Op1vycnflXLGxxBBAuJnQFJ8+IR9d14uAFdjUJLVBANmd1ko3FjibXDTxKr
	 6dj8kObXCwadW9tMONR6jE8wDF9KqCHLEB1oA5pidfi9dnB9GNPLkiqP+mYZvqCnjj
	 dBgigwKXETtLs9d4jj20MS1EmkqOA/SVUMPzGI8sGE7h+eAIloqASpE8iq9FjYPAuD
	 YIWMvRj2xNqzg==
Date: Tue, 1 Sep 2026 17:06:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 syzbot+989ff6506f5c6d1ff56b@syzkaller.appspot.com
Subject: Re: [PATCH net] netdevsim: take bus device refcount before
 registering device
Message-ID: <20260901170626.6136cdf1@kernel.org>
In-Reply-To: <20260831183952.1345042-1-adrianox@gmail.com>
References: <20260831183952.1345042-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 14:39:52 -0400 Adriano Cordova wrote:
> nsim_bus_dev_release() drops nsim_bus_devs when a device is freed, but
> the matching increment was done in new_device_store() only after
> nsim_bus_dev_new() returned successfully.  When device_register() failed
> inside nsim_bus_dev_new(), put_device() invoked the release callback and
> decremented nsim_bus_devs without the increment, driving the refcount to
> zero.  A later successful device creation then incremented from zero and
> triggered:
> 
>   refcount_t: addition on 0; use-after-free.
> 
> Increment nsim_bus_devs in nsim_bus_dev_new() before device_register() so
> the release callback's decrement is balanced on both the success and error
> paths.

This is still racy, please squash this into v2:

@@ -520,8 +520,6 @@ void nsim_bus_exit(void)
 
        /* Disallow using resources */
        smp_store_release(&nsim_bus_enable, false);
-       if (refcount_dec_and_test(&nsim_bus_devs))
-               complete(&nsim_bus_devs_released);
 
        mutex_lock(&nsim_bus_dev_list_lock);
        list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
@@ -530,6 +528,9 @@ void nsim_bus_exit(void)
        }
        mutex_unlock(&nsim_bus_dev_list_lock);
 
+       if (refcount_dec_and_test(&nsim_bus_devs))
+               complete(&nsim_bus_devs_released);
+
        wait_for_completion(&nsim_bus_devs_released);
 
        driver_unregister(&nsim_driver);
-- 
pw-bot: cr
