Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B01348463
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316848; cv=pass; b=fQlL2XIe12OVxuIQ+UXUlTini6k0a7UjaNjG9kaggqS45OAO9R/PtzvXRuajEJKn7tbgWHYCYA/DAtM4HY+8aU9G0QbiLkZsrNyvd/PRV/TgskU58gDPZP4bEdgg1nxiGjouiCHgEAZ0ZY5s3XDUBRVfS18Vk3cYFkLZtuSzeqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316848; c=relaxed/simple;
	bh=Z2+x0bVuX2JZuXF66F8NzOj726FZhm0l0KRuCmFB0LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7xwbDDhnY8wQMv8RbJ6Ywv1lqM9LV+kAD5MRPEIJtsmcB5iRKcB2fh93cjKA3KfaOVE7OBhJS4Ndjq4bbdIPq5eiBwqaGEXD/J6pm5821Ojyyjy3Nc0Sp5IW/KYtxt7y5mEr46kQKNB/+8IGwiNApsKDQzLcQhMBvxbZ0zt9ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhpA09/D; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhpA09/D"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c16ac21acso33135531cf.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784316846; cv=none;
        d=google.com; s=arc-20260327;
        b=ATRijJItyOLOaPO8X/eKmxaSrJDTPt3gF2KCUwzPXA8De33gD4z03Mp1JPww9cSg5C
         OXNBi1bnM+hCumNnLpG3TcJpNlL05Ajm10khaeBJMgj12Ff63j1sLXv8nKmxY8N6zaEr
         jvBhDiXacRtM93CBR5vfhTCjeDf92ddMvGFmXW9itOF8DhwIb/qgosLtb0m+sanjq8Iy
         8wiLGUdP7nHEPLDdss0yhaBsy1kjPN7hMlAjYSkLkRKWFm5lu2tnNFdcnrunV4ZJzaCq
         KNqxD8OS2/8PLySeFKyXo4VQ/8BdyGrXU+cjtJcFIvEI/7YKBL8CzG6X7yh3L4YfeOOT
         qtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0VXJKOtnkf44j+tQQsqQzA0l3vLSi+Q72kwccQQQrtI=;
        fh=yk2y95PlfMOnWhUEUCzvHk3DC1x7wgOGpundRCmWG8M=;
        b=dYL4z9MFTg18FTqOBtQJkJcKHLcTDR7LPGvrjRlnbG/yMEDygS3kMX9yNkeYqG8Tpt
         BFi9CTzzE1y7JusCTGeSVyE75IzqK557qBK38pG3NoQYEli1ZQ4C18qb7r4LLdlLA3Nx
         6D2OyYDPbKCsawTH2LCTf0pGcQiBDWMhxl95RlkeRCmK+vq434PJtypQMUaQoBCNHpfn
         MEiucQaQm5qTSspkSWemmWPM6H+aBlSRv/0KSPqhRXvDgvMOYXTV4nCBqQsR7IZKUfxG
         GjPXFwcV7X5j66zYQQW044HCGeeBwXwYUHHgZYNLqf+snZiMOqgRFsxXPS+xHlVIdBUZ
         VQyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784316846; x=1784921646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0VXJKOtnkf44j+tQQsqQzA0l3vLSi+Q72kwccQQQrtI=;
        b=GhpA09/DoCfXdyGGw7zJ9bP9uoHcFXAbDYNrOfZd4UlF6r56MqXBISyGIx0DH/aA+8
         flc7lUkG2oUgoH+SEAnwAWbY600DXVGjWpnBy9jxSUoMCWJQb+eCSukiujd8/C3fOhn5
         VFWqs9q9rCDcJgKCFmwZFGrX5QAtWniCUAuW5ajgJl5qX0QYd4I7gUd3anDnsoxYlR2N
         GsytER35otGTNYcygF2S+3nvQLb7JN7ql6TcKD22THvKQcHMcqqyqCEZIqPRO1wV9HfD
         Y2opmcQUoxDtfe244ASkRTcS7TugCUGj10aQhJA+w01AQAFu7xg1esbIO02vwCeDhA4h
         Cz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316846; x=1784921646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VXJKOtnkf44j+tQQsqQzA0l3vLSi+Q72kwccQQQrtI=;
        b=Yav/rfqqAVSNDb0Uoyu5XXOa7t40+pCVzwl7RNFI95uURoLIU9lz37XbxYKnDMuY+h
         As2+CDPNO4OFCLmTuAuCovHcEnhcqVy/fPPtbjfN/jXpFp7NV7bkFBcxwGpBlBTe/n2g
         ahsU0pT7PfA6/9YW6aobST3JL3dgcALQTTj6HThj0JDy4rV0U6HKmbc1uUNjVEEmlx1R
         OptpDfx8nBVKP6a7l9Ki33d7Pm/NwXOS+CrtPzmFAkOnou/B95hWVJspo6wKn2YTBoZh
         sxnl5vIfAd+KAQa6ZjAA9/JbZ1CD/aaUXTf2CKYV7usAk9DXWJRc9jlabpw4qdgbb3j6
         cEbw==
X-Gm-Message-State: AOJu0YyhIKDAftN2uCjhr1dVCzS3eBuxo399NGNeywD0nt793uUDP7X5
	A99HfCoAClu6Rs1hAJGxDCPLolkSPIfef6EJAN6bjqVKHvP0HFKv8mGlcXIaUUoT+EB29MA657O
	VMfcC16SJpoOiU+zVR6nt9BySQCUc1czRAU7cQvXP
X-Gm-Gg: AfdE7cllOD8uFEndl/3ACxk40fmvYwmVTZuVOQEpxWMo8+PyjKkX3ogT1+QHxqamBdF
	pEl+O2jb/yz+DwOrWlKKy6hHXyZ/89AWlqf8Qicd0qdyAP6W6khyuMKYbYWHW2HKl/nUUZzCtsk
	aXcya87vyWVBbivsAdj3FVvRD+096QNPR/fEHgJ9B3gCRZmVRzuYZd3zq76IFreoJ+D1bdJ0Xil
	bWcF35wIrFlRgdEGHdFs+cxzDN8jDY34F3H+3d4BdFwudM7w1yQWCQVbRRLzqRGlNq5d6uLODyd
	YBFuT632grupu3xHEqhKFoMG7l7yDNrfy7+PrxOYmxf0qwRLbMFUE3KqBj1IZAHTanhqtvZ5a/4
	EdPAagvsz
X-Received: by 2002:a05:622a:a05:b0:51c:1c00:e46 with SMTP id
 d75a77b69052e-5213c7e8436mr37586171cf.25.1784316845085; Fri, 17 Jul 2026
 12:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717074109.686170-1-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260717074109.686170-1-yangyx22@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jul 2026 21:33:52 +0200
X-Gm-Features: AUfX_mzjSXpXhmgPyFW5IUal0VGKT4ixqqI6k9wW0PNFr2YNbw4acNqb_17YTjk
Message-ID: <CANn89iLK7dN3JObPGCsgep5aCobrfT-gKpdPpmG3uZwgyOwa7Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: reject impossible oversized fragments at queue time
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 9:41=E2=80=AFAM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> ip_frag_queue() computes each incoming fragment's end offset and may
> store it in qp->q.len without checking that the fragment can fit within
> the 65535 byte IPv4 datagram limit, even with the minimum IPv4 header.
> The only 65535 byte check lives later in ip_frag_reasm(), after the
> fragment has already been accepted into the reassembly queue and has
> updated its state.
>
> A fragment whose end offset exceeds 65535 minus the minimum 20-byte IPv4
> header cannot be part of any valid IPv4 datagram. Letting it update
> qp->q.len leaves the shared reassembly queue with an impossible expected
> length. A later legitimate two-fragment datagram sharing that key can no
> longer complete reassembly and is not delivered.
>
> This was verified at runtime on Linux 6.12.93-0-virt. A same-key
> oversized-fragment injection (offset 65528, payload 8, end 65536) drove
> legitimate two-fragment UDP delivery from 8/8 to 0/8, while a cross-ID
> control stayed at 8/8.
>
> With this change applied to net main, the same-key test delivered 8/8.
> A valid 65535-byte datagram with a 20-byte header was also delivered with
> both in-order and reverse-order fragments; its 65507-byte UDP payload
> was intact in both cases.
>
> Add a per-fragment bound check in ip_frag_queue() right after computing
> end and before any qp->q.len update or skb insertion. IPv4 always needs
> at least a struct iphdr, so an end offset greater than IP_MAX_MTU minus
> sizeof(struct iphdr) cannot fit in any valid IPv4 datagram. Use that
> minimum-header bound rather than the current fragment's IHL because
> fragments may arrive out of order and the first fragment may carry
> non-copied options that later fragments lack. The existing check in
> ip_frag_reasm() continues to validate the final length against the
> actual header length of the first fragment.
>
> Drop only the invalid skb so an existing queue for the same key remains
> intact.

I have a hard time understanding the issue.

This is an invalid packet, why should we add more bloat to
the kernel just to 'optimize' this case?

You understand that IP frags are unreliable no matter how hard we try
to 'fix' them, right ?



>
> The issue was found by Yuxiang Yang, Yizhou Zhao, Ao Wang, Xuewei Feng,
> Qi Li, and Ke Xu, with assistance from GLM-5.2 by Z.ai.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> ---
>  net/ipv4/ip_fragment.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index c790d2f49..32e5240a5 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -291,6 +291,8 @@ static int ip_frag_queue(struct ipq *qp, struct sk_bu=
ff *skb, int *refs)
>         /* Determine the position of this fragment. */
>         end =3D offset + skb->len - skb_network_offset(skb) - ihl;
>         err =3D -EINVAL;
> +       if (end > IP_MAX_MTU - sizeof(struct iphdr))
> +               goto err;
>
>         /* Is this the final fragment? */
>         if ((flags & IP_MF) =3D=3D 0) {
> --
> 2.34.1
>
