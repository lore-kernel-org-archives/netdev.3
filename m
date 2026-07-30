Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FE32ED40;
	Thu, 30 Jul 2026 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372076; cv=none; b=gjD3E6u+V7X7bY7x0olbhn2oW//5Yz1+lERHbVAc21YDQkbpzJDk+kxhiM6dthGQlozgXf727ZIAVGrPBg+gSug0fKlBI1Z8f0byP2ssLfI+rFHU333y1uKl6tedvtlQZpY9Pcwabdo0A0DKaKz5eZWMszgPfzAyZbtlmdU389A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372076; c=relaxed/simple;
	bh=/NI8mAD/AyqDMAUOAmoPKauA+pJ62L+6AofS9/xB7Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3R0CO6Z8sR0BxphU7L+8QyatoUZGWIPuJU8miC0JuItjfBAxPhfaESD8WOLtuEkusjbWhFDVzrCyZ6XTPyRGnnEXrxB70qmG8LN/yoh1HaNd4cUS3I7/Sm5hmKfhqr1pohWGPVtVywrslQFOeZsLVeh5s2M9/KExIC40o7A8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpEMbfTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpEMbfTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF311F000E9;
	Thu, 30 Jul 2026 00:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785372074;
	bh=uz+iQj5wDy/7ZLwhxHqm6mJQYHEjaf3YmJWLfeHhXQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZpEMbfTsWPJ3VAf+jb4PUQYOd+bVBATsVC5T9Ibb0Ot0efgwoOpJIJ7OihPNeZ8YM
	 PCG+HYGUN4k/HJhbfx1/mPm0nwYslE3E7umn/70TELwN2+ytD/Ir/oZ+ppNKV0Mdad
	 46+MXoV17yt35afukmQfYHMx0tXVOfqKTS1a0sJGHhanPlyRuAhYMVoOv+9lgqjdut
	 e1i3pkl3OPIBDaZ3LOEsjEu5HOqGKh3xcbn+1sGHAoIIIOnmGJVBNGhKeseFp5S1QY
	 9us65wbE863ynQY9VcMhUIYeCVnxMwweyLxR1HY5Na1ec417sYKk50TBWp++GXYSbJ
	 rCzj6KxHRpmig==
Date: Wed, 29 Jul 2026 17:41:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minhong He <heminhong@kylinos.cn>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: failover: check register_netdevice_notifier()
 error in failover_init()
Message-ID: <20260729174113.66d99166@kernel.org>
In-Reply-To: <20260728031033.76431-1-heminhong@kylinos.cn>
References: <20260728031033.76431-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 11:10:33 +0800 Minhong He wrote:
> -	register_netdevice_notifier(&failover_notifier);
> +	int err;
> +
> +	err = register_netdevice_notifier(&failover_notifier);
> +	if (err)
> +		return err;
>  
>  	return 0;

why add int err:

{
	return register_netdevice_notifier(&failover_notifier);
}
-- 
pw-bot: cr
