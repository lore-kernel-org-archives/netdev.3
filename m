Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365634DCD2
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008372; cv=none; b=QDvxuDxO92qkR+a7LBYZbpYYbTr6HuBawBQvoLSHz7sxtJU3YF/WCv/B3HQu5tom9gc0ZMfA9b0ZhZNpqWWIe6dYNI/GolppsjwwJJMwuPEhyGvv6o3rYMxmZMkcKyrso3sNQsbZjGWYGpKWovUW6+5/ANWZGs4XZVuWHeu8nUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008372; c=relaxed/simple;
	bh=E663tdbelNZw4Z9JLlkVwqBD1/5bRlaZn944JUFkOY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpOljVCqsb6hfMrvAPJnU9IISL9vezC+S3r6VZlRaSmOD1LNNVa5OLqEM04X7D8dJWzhQxFt81x7l9iVFnX5mPkzHYKmu5itZdvyPGvkuX02nSeB3KOCSIMmpwRBgFNwG+9UVpFZKMaTvC2lR5xcCCgzxtA5fzDY6RBZhNscWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCZQCx+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCZQCx+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1F61F000E9;
	Mon, 17 Aug 2026 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008371;
	bh=jFzhHJe/LoBE5UONMqrdalOUE5RBcyrD2T1LUATMyb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TCZQCx+XBI8NBuBCFFpmOLZ1MZuR488FAWlaHrjWfatkyM+VCZ0ocbRp7Qtbj3k7U
	 g7B0KUri/0b9wpI6GjcgpR5aB0TQTDSk6TzXUy6U1Pf/oBNKP7DK8uSwSOsQCBuX90
	 42hFbWwjOsmzD1zJKKX2uuoPcWb01YBf0nUw/H4rvZyhAuzPhgpdlKp7CQqB2Lb7bz
	 EgYllyk0/Yyvlt5SJoXaR+rzJG8er3PiFv/0iMmP6o0KJ23Z1ZNMSRjvOv6OUpSsfc
	 WiLkb1XnmlP6b0SeW9VHDOZcYc1mEbFKGlPUSyumEEmg3mYFrNRq2FJrxg0JtQN3wr
	 hqa+dtxj6sLpw==
Date: Mon, 17 Aug 2026 16:12:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v6 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Message-ID: <20260817161250.1ca33d86@kernel.org>
In-Reply-To: <20260813020529.3506539-2-willemdebruijn.kernel@gmail.com>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
	<20260813020529.3506539-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 22:03:56 -0400 Willem de Bruijn wrote:
> The 'max_pacing_offload_horizon' field of 'struct net_device' represents
> the maximum pacing offload horizon supported by the device.
> 
> Add a new field 'pacing_offload_horizon' to store the active pacing
> offload horizon.
> 
> The new attribute is initialized to 0 (disabled) and can be set from
> userspace via RTM_SETLINK up to dev->max_pacing_offload_horizon. This
> new default off behavior does not cause regressions, as no driver yet
> advertises max_pacing_offload_horizon.
> 
> The attribute is omitted from the newlink request spec, because the
> value may need to be bound by a device maximum that first needs to be
> negotiated with firmware, as is the case for the idpf driver in this
> series.
> 
> Make both fields u32, to maintain net_device cacheline layout. This
> expresses up to 4s of pacing offload, which is sufficient.
> 
> Update the YNL specification ('rt-link.yaml') to add the
> 'pacing-offload-horizon' attribute and include it in link-all-attrs.

Forgive my slowness but I don't get how the new param squares against
TCA_FQ_OFFLOAD_HORIZON. IIRC in v5 review I asked something like "should 
this new option be a boolean" because the exact time horizon already
exists in the qdisc uAPI. As AI points out (among other things),
the two params are not synced in anyway. User can configure qdisc
offload higher than the device level one. In fact any non-zero value of
the device one acts the same - hence the bool question.

Why do we need both? How are you going to use this new knob?
The commit msg explains the what not the why.

My naive understanding is that the main missing piece is a handshake
between the driver and qdisc to tell the driver that the qdisc is
indeed offloading pacing on queue X. And therefore the driver should
pay attention to the timestamps. This does not require uAPI changes.

>  python3 tools/net/ynl/pyynl/cli.py \

uber-nit: python3 tools/net/ynl/pyynl/cli.py -> ynl
(the CLI is named ynl when packaged for end users)
