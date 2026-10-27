Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078759;
	b=ZGXsh5ljYUwKQHIhuLBYyxsjpg1JgkJ6e6V0wWWz4YTTPFQewPnvDvUcaLrvAR7j+3ft
	 NtaCHHK5n3oqIANpTsOTt9lKE6WF/DF5U8DycomVnD9MshvH/RrUHgKCmfRoFpldxEWTP
	 bD9hNjcbkLLtYAL8JJAIf5WYu8yE2v6I3a2hzg6Jun/COYrwrwZRUY6LKUYwtl1Jljzlp
	 g8xP1w7HRMSXliEygxChmhVd4U1VtRMIZmgorQ4SPIWULVASiHOPLWIllEKzeN0kOa44J
	 JIsZE8jHf1cedKybJzX60t6FpJIYf4du84agKXTvxB7sntEC7TQwaa7LpDglgEHDa/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Pk2xdMK10hT40KD5CUAdEEdDpEBTBps9sOPk5PNQLsU=;
	b=OlN5U0YagQ0ixspjb+ABui691B8Y3rM06wVemFLRDU1QmQp7Fc5anUMi4ligWpaSTu6P
	 OdbHijbN6fAszamutoq17e57NCLc61LXWWvRlJSdNTRMhuQUg4pnlTQiv2EqvFTrVUD+o
	 Gj6FtxWX1NSuq6lVH0NkYZo8z1iaQnudtAk9EKk+izv+XzmHYXDMRA7msLql6T6/pw1Vx
	 O++ZVJr3yza0aXoSFGSyyDl3Ryp67aIwR9QG1AVytJJzHhm4t+snmb4IkLUxOJldP0fGO
	 bFsP6Tq+ajT8bbi6EFSCDvLe1d3RxDwypXjV6kIpd+pQuEl7Gnk+bazWRj1cjz5yg8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QRWcLGqH;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35368606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35368606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QRWcLGqH
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0589ff620so2610500b3a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793078758; x=1793683558; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pk2xdMK10hT40KD5CUAdEEdDpEBTBps9sOPk5PNQLsU=;
        b=QRWcLGqH17g9FPCcjJskjq66HFz7uY7trYydtohVQNEexL2hCrsvufT6YVefa3Y3BA
         NnBk8IIsBXpvpuxuRW4QJeNedwACLA7w5iBiZhrWY5avnk7Y8KRlFegRlvZZ985VvqnF
         bsSPz5JQaTk9liv41wCI23r2dpTDtm9F5Kqms8Wm++oWqEG03x0ITA4bCzDM/nRkAzK9
         q2TbU3gh8rnVZ1nG+N+ZN+NX3ffne2GuS17I5R3QJiVF0G+6C/j3greZ2GhE2bYqmg8A
         tt5GyAwm1R4saEv6V303HtY0ftYVi85up3lVpte4FEhdDNz8DFos7Bzz6XPhc8fUH2Ap
         kmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078758; x=1793683558;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pk2xdMK10hT40KD5CUAdEEdDpEBTBps9sOPk5PNQLsU=;
        b=x9KtEYATN8yA87SS2CM4IaHUM1CoyelM2Z0yBAulxF+cG9Z2GEZrZz0bv8yvSA+cTs
         g5edvg2cTnsP/uB4cBNIOQSc6bRCcxaOWtyYdUugxq2ZUw1rNXA2ojK91XaGKOXjBhFU
         OfEjLqXpr2Bs+RHDiBDggETg72R/0t+tsUQpmU5UiglF97dGljqi88i6votNYPChnaTs
         iUet+68n+xcQ3K3gqigBVRo9z2N1W+JFuDOHX8Bpqg4EQHWvJgliP5b8Fi6OAeN5DpxN
         MY7RnILWp6P4zWJ+04feRTAnvOCJmPhWAAEN2HHnNS2hMBdpxw33sAepHrQawaGnuISn
         KeEg==
X-Gm-Message-State: AFq9FYJ8ap0NTVlZd6ECBL7oijK8/baC3wLUcsWz1lgpsfJXZ0iFc27N
	Moz2zuWl9hu6A9W9dbjSNZXlQxFWisxF6RBTyYhAPCBm3UYJVfk/PbVqt54ByNTt6+cMprmjeYQ
	x/TIyOg==
X-Received: from pfch21.prod.google.com ([2002:a05:6a00:1715:b0:88e:a52b:ec70])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9099:b0:8a0:6414:a54c
 with SMTP id d2e1a72fcca58-8a3687bab25mr7459477b3a.32.1793078758343; Mon, 26
 Oct 2026 22:25:58 -0700 (PDT)
Date: Tue, 27 Oct 2026 05:25:57 +0000
In-Reply-To: <20261023091419.167088-5-jiayuan.chen@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023091419.167088-1-jiayuan.chen@linux.dev> <20261023091419.167088-5-jiayuan.chen@linux.dev>
Message-ID: <auA1zqalNB5UrXJq@google.com>
Subject: Re: [PATCH net 4/5] ipv4: restrict igmp_qrv to 255
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Yung Chih Su <yuuchihsu@gmail.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	Petr Mladek <pmladek@suse.com>, "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 23 Oct 2026 17:13:30 +0800, Jiayuan Chen wrote:
> net.ipv4.igmp_qrv only has a lower bound, but ip_mc_reset() stores it
> into the u8 in_device::mr_qrv, and the IGMPv3 retransmit counters filled
> from it (crcount, sf_crcount) are u8 as well. Anything above 255
> silently wraps. With 256, mr_qrv becomes 0, every
> "in_dev->mr_qrv ?: sysctl_igmp_qrv" falls back to 256, which truncates
> to 0 again in crcount, and igmpv3_send_cr() never puts the state change
> records for the group into a report. The older version querier present
> timeout (mr_qrv * mr_qi + mr_qri) also collapses to just mr_qri.
> 
> Unlike MLD there is no WARN_ON() here, the reports just go missing.
> 
> Cap the sysctl at U8_MAX, the largest value mr_qrv can actually hold.
> 
> Fixes: a9fe8e29945d ("ipv4: implement igmp_qrv sysctl to tune igmp robustness variable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/ipv4/sysctl_net_ipv4.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index e3760daa3470..ef631a2759b0 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -33,6 +33,7 @@ static int ip_privileged_port_min;
>  static int ip_privileged_port_max = 65535;
>  static int ip_ttl_min = 1;
>  static int ip_ttl_max = 255;
> +static int igmp_qrv_max __maybe_unused = U8_MAX;
>  static int tcp_syn_retries_min = 1;
>  static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
>  static int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
> @@ -978,7 +979,8 @@ static const struct ctl_table ipv4_net_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,

Same, please use proc_dou8vec_minmax().


> -		.extra1		= SYSCTL_ONE
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= &igmp_qrv_max,
>  	},
>  #endif
>  	{
> -- 
> 2.43.0
> 
