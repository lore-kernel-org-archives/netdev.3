Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9D1D88B4;
	Fri, 19 Jun 2026 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830367; cv=none; b=ZnmatRcFCx3lzxtSBTSnAkNmv/H0RAogiXm+aXf9ZrKCTcrKVFIpaU0ekJT4ji+AHJVT7TMWVqjj/2ALAUWnhiZELxL+BT966/+00U4olafDi8PRKGfdZ9HqIvP1QMx1yWCgFY9YpjfGAnyjoAV8GU+o/sRw3o/d3wtdpqXNoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830367; c=relaxed/simple;
	bh=+PRrW/2SN3BbJGLnS8WOoy4So+Fs/MDB0do3UquF96M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiAYE8uj6q/PD6ROGsPaIdew056i6HByAc6V99sbZh6foT5J3Pwu1m8oGBbpTauaHqoUBTT/rgbvhBjGM3IcZBZzLB8m9U0iHsABfJ3mvvyEwk3aomPkZVc4UlM+Dx3de8qUSsw/+IaL6BILmj2vlpmaZ83Xs6tGznzHm64/L8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaKHXy0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaKHXy0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48ED31F000E9;
	Fri, 19 Jun 2026 00:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830366;
	bh=oX92llFN1p3l7JzPvmVkiWUJ60Kak+9P0cVKOb/guBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UaKHXy0L+HqCpefmwZa/Z0bTs121U7SefTShomyUKLC+F73MhOq0xi+Qmj8zJa4zC
	 lMAinFBtVVDsbuarpfCloP9VtMozQa1jcB67oDq8umKKPb1Au5jPTf+yp/SYcc8Bko
	 E5ZjypV1FmRCv2ZL3AuoQhb0eSS9ftU37vEQOVOu1iKBgTW0OFHI29Quc9mJ66C3cd
	 oXMWMiZOPx6YFgASluST2tj9YhWLMiaqyQsqJJKnKsYVFe86xS+tSd3D4v5nwKzrch
	 fxwGAcY948qRhX62WHNVraxIqZKOJcMfeqAD/q0ocXwhHyO2Xm/XZzg3b1Fepz7x8p
	 PeXecAGIx5YGQ==
Date: Thu, 18 Jun 2026 17:52:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: joel.granados@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
 niecheng1@uniontech.com
Subject: Re: [PATCH net] net: llc: make empty have static storage duration
Message-ID: <20260618175245.25c0c523@kernel.org>
In-Reply-To: <20260616064053.690154-1-guanwentao@uniontech.com>
References: <20260616064053.690154-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 14:40:53 +0800 Wentao Guan wrote:
> Make empty have static storage duration (like net/sysctl_net.c does) to
> avoid a potential use-after-return and keep consistent with
> __register_sysctl_table @table 'should not be free'd after registration'.
> 
> Fixes: 73dbd8cf7947 ("net: Remove ctl_table sentinel elements from several networking subsystems")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  net/llc/sysctl_net_llc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
> index c8d88e2508fce..15f1e5d88f208 100644
> --- a/net/llc/sysctl_net_llc.c
> +++ b/net/llc/sysctl_net_llc.c
> @@ -47,7 +47,7 @@ static struct ctl_table_header *llc_station_header;
>  
>  int __init llc_sysctl_init(void)
>  {
> -	struct ctl_table empty[1] = {};
> +	static struct ctl_table empty[1] = {};
>  	llc2_timeout_header = register_net_sysctl(&init_net, "net/llc/llc2/timeout", llc2_timeout_table);
>  	llc_station_header = register_net_sysctl_sz(&init_net, "net/llc/station", empty, 0);

I will apply this but it's not a bug.

The size is 0, even tho the pointer is stored there can be no access.
