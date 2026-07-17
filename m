Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861836E460
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303618; cv=pass; b=HqGAYCdAUiOM3Fga0Q2Eg/b9W0+N+ivvgZ21IE2yIElk6cg/4FhfJ40TE1RH8rFVk9Und9DecozAeq7ZYuo/rD5LHivkhoYQLC0s4AwTQ1y+QPK2MqrxwRToz3mntV/I3S68kR83FPGdq2Q9uAGzZrvp/Bhlzkz7nr4vXBMlXCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303618; c=relaxed/simple;
	bh=lpAe0xAk3UPPvUR2fW1+fv1t9rIwTpbysjHxIFUDCLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmwDchoAHZWhxYB/OlPUErl/v8tfU+5/upL5o5Lb925uQO/9LjIDnbnpcKCe7viWbRidkJo4yqcr0MCCChiR5QfH2QZQe8ql6XWeOE0KTgay8l5oYBpqdwCalcJcAtUsxWCUMYzcTvaT4DvUJHlcOOYYdqNzidIKiuXV28+UlG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o67YOztn; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o67YOztn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848643382fcso9211289b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784303617; cv=none;
        d=google.com; s=arc-20260327;
        b=XzMpYZ4AFhfx7pqyBRvKbwK0Uw4ysS81FtkcyoZ9QtUvDx+m6P5s1v8a7XN7/7oj6c
         SywAiEfzU1MftFZCIRn4nx1lMGCTHUrodZKq4jKZaNDbMs7bUZ4DYTfyY5h30PwKBB82
         BwpqcWgA0q9KUT20Lhx7d2lT9xVzvATqKYDO9gaUUUdRA+qdj9B+vOmax7BWV9uT3Epo
         WzH+EzbAosd1J2qPP42t2HlHxlvP/HwKNciH01aWVy/+VJ9TR6UWUiNLVzl6REUKosPI
         VuW6t2qNsJNuteI3WxCjJuU7Sd9Sem5mfEg+c1sxwgy2GPcFF8Q0LwUAbfvJv2Lmx1z8
         WKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xM9ijI7eNaRyNI3DueGXfkvoObRorwP48DrsWZ89mA=;
        fh=uQADOk81kBL3PdpKso+9FHGbfzPXW3hQHB8Zq8IIadg=;
        b=GG/g7jO0xatP7PfhW99du7XUPp7AJguzILa/aW3yG+nu6RteJ0bkd60dvG0d03MEPC
         gCgWpsjh8fYBATTiaIF+V7q+59aGv30r2bpsXhkH4aikZsW8yefEb0zkhav3BMCZa6I1
         7boarbsXT6G9NC+Am+BrZaMksp5muvjWPUpY26kdEcAWzgl3WamlIsuOAc3ghVmwMUsy
         BzBvwXM6lHbWsrKCC/zUxCHtqY6Vy+ggIXCJccfbmdFeA5Z46YDJSDIsiLkuc0JFue8S
         Vg7QXYUhBSUsnI4Jva5G0uVwh+GdfJNXPZStVTe8ly6vH/lxEFYXYOO42H64WalN7pue
         FN1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303617; x=1784908417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4xM9ijI7eNaRyNI3DueGXfkvoObRorwP48DrsWZ89mA=;
        b=o67YOztnQDE58O2YefuJBol/P08GHEjdXL3t5WQFHI/zljklWrh7VZZ6JHhjw/XIf2
         uCC2W7uJyzXD3qerERkSXjwmAJgrqDLZB7RMRmTUloIIRh8TEVndpu2jeKoTEa0KUYze
         jfGGqeAu84XDoPm2W4llkrqAlmh/YIyQFfzaNUmqukbd2q3aG7dDTpjZHk9LbJBOqKw8
         nwGXUfmjlzmGBdgAXNIopB0NAun34B1QDXykjCvnLJhO7bhBrjLGL9jDYDhAcXs2NT08
         23Y72rDmNAdk/5zUS9Rv3aZhQuJdZ6UM7SUA5htmrjmSgN5FvTCdpFvvFfVs4G+lNwXs
         zfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303617; x=1784908417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xM9ijI7eNaRyNI3DueGXfkvoObRorwP48DrsWZ89mA=;
        b=L1l3Y+yaZKh3x8oTszZ2Gn8HFrMuou/gGWnTtiiU9XDlGWGPCRj1sR7TQonjnLSmnw
         qUEcmHMXOfjVl9i9KyDUnV9i4PguCjQ7qkpNYsCt9PagPt1PDHiPF3kJ8vAaIpiurPli
         xWrJhcnjXQP26SW4Ii6Im4Gba/MDaTE1u7bg0CAMtQa38ru3gmX7rvIcqqlmMkXN/JmG
         6fV53fhkCE0SvTXdUFtO0Fpmuk0WOpHY32qH+OmNkEBhLarjJke+M8Qh/TBjRdG2W8BS
         PeUKOzod4n9B2QdiRVvhGF8gcg/3T41yZodvK8YTo4qUNkXbiwybDgxfCJcqyWPlGK/K
         wf3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrmulU0EZpal3riVPOI6CbF/D3uv7ApWEaN/Pi3T14/7rFBLdEZGakf2SAZtGfn7Td00G963V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHyLMz97FAxoLKr/ZjsiqS6HNhGrfpcbGcr6tTVQ6u52qcd8F
	tkuikP7E3W243ibuDl8Sxlnc7dvftBPMvSn5C00khAqVu/vZquLJComxDRuRqOFs5KsUK0mVgr5
	LLUbIUVLXvp9AJcz3fjE1l8UTdF3yLSVl0ryW
X-Gm-Gg: AfdE7cm7goQY6pfTGD0uXIGYaa/VUgFLPqb0gdCZyVFiFxPmaIzS+RYPjWrF1JJVAlz
	H0+rQdgcIEwDZkiZJ29wFx+EbDgnLm67d2a55ROpuFtyUF+fJul8L1AKDKOBAe8AL8TMyH5F6ot
	qFaCuy22oGAmA4nf4px479vKfq9E9OvlXlmIfOOsr/cPB+HtZzjdxr+oJojrx7LibAMgxjqwDO9
	KPJ9MDufIy2mczMzTrbPhCZMeoJ2UNZCb+LgNelV7CjjlMFaArHwu4M+xjrETOa465FHZED2kR/
	W+vjkpXwf5y3fBJf9ysDwAIzhi+8K+G4dSFKEaYDURVyamO0uxX80zgUP4Pw6eaGO1ZlI9nFhA=
	=
X-Received: by 2002:a05:6a00:600a:b0:848:2f73:8ffd with SMTP id
 d2e1a72fcca58-84c29527f98mr3396780b3a.70.1784303616665; Fri, 17 Jul 2026
 08:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717143315.1942-1-lirongqing@baidu.com>
In-Reply-To: <20260717143315.1942-1-lirongqing@baidu.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 17 Jul 2026 11:53:25 -0400
X-Gm-Features: AUfX_mxGU8bu5-y4iiwqoxhcp5tvoKqtyL6O9fFy7Chy227PrDtkXxGEFp4t_z0
Message-ID: <CADvbK_cEUR9m-QyKi5jj2MTqF2kGbBj7d1mUXmCsHgDLNJ-bPQ@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix a potential use-after-free in ip4ip6_err
To: lirongqing <lirongqing@baidu.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 10:33=E2=80=AFAM lirongqing <lirongqing@baidu.com> =
wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Fix a use-after-free bug in ip4ip6_err() where rt->rt_flags is accessed
> after the route entry object has been released via ip_rt_put(rt).
>
> If ip_rt_put() decrements the reference count to zero and frees the
> rtable structure, reading rt->rt_flags immediately afterward
> results in a use-after-free pointer dereference.
>
> Fix this by caching rt->rt_flags into a local variable before calling
> ip_rt_put().
>
> Fixes: 77552cfa39c4 ("ip6_tunnel: clean up ip4ip6 and ip6ip6's err_handle=
rs")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  net/ipv6/ip6_tunnel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index bf8e40a..984cb0c 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -569,6 +569,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm=
 *opt,
>  {
>         __u32 rel_info =3D ntohl(info);
>         const struct iphdr *eiph;
> +       unsigned int rt_flags;
>         struct sk_buff *skb2;
>         int err, rel_msg =3D 0;
>         u8 rel_type =3D type;
> @@ -627,10 +628,11 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_pa=
rm *opt,
>                 goto out;
>
>         skb2->dev =3D rt->dst.dev;
> +       rt_flags =3D rt->rt_flags;
>         ip_rt_put(rt);
>
>         /* route "incoming" packet */
> -       if (rt->rt_flags & RTCF_LOCAL) {
> +       if (rt_flags & RTCF_LOCAL) {
>                 rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NUL=
L,
>                                            eiph->daddr, eiph->saddr, 0, 0=
,
>                                            IPPROTO_IPIP,
> --
> 2.9.4
>
Have you already seen any problem triggered by this?

I don't really think there's a use-after-free issue here.

The entire IPv6 input path, including ICMPv6 error handling, runs under
rcu_read_lock(). Since dst_release() uses call_rcu_hurry() to defer the
actual freeing until after the RCU grace period, accessing rt->rt_flags
after ip_rt_put(rt) is completely safe in this context.

Thanks.
