Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793238825;
	b=VONTE9laRwvs/I8cRXPR7B4jfvU0wlX0tqhOYiTCqBMGQ1s3APwzJT90SOUW2S4C8ie8
	 WI6b+aQWiDEnLt8/KPUWYfbfXIrZ17fFfdAlongh+OqveKRx+Bd3YFFx79FxTR+vHsqJ4
	 mb6IjfoqbsUM2ZtSHz9CR/gZmoFGqrQU1Z84Mb1j1EySncQEk/hWaG/lDBvaMnZJ8ncE+
	 H7FrgmZcKDFbC0L6+S5/s+XH+yRqr9Ys6kh9bMkfugk0wSG2KMDu9K8BwzcbgK/UCzbua
	 Oq1ok/ULBwzXlFfzwVopnzaSxIIBGk5llBJnJhDxIFR8prkDisN8oZjhvWRs1enZBXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
	b=uv+E35nNB0GrNkQDKqEPhHAjgKFEJrzy6bw3kukhDz8PLgNu3xxjT5S0aLxcGNXMyEZh
	 /yPLKUVB4itNyEq0ALqwEctr9Fc27kD35PPNeVnyWWwWR2b6ktKBaySrJ0mUIa6TI6QLs
	 JayNJYvFW3XlfkK2oROAFzk232jx5okybCHD3ES+mjqMxnxJ1u8giV1lFB082Rubyb8kG
	 OaU6DjXHbst0RDXtTU53cb6ZOWKkYL59OQCX35bUu0KZSrR63VFGRrbxBc0+iwungzNXQ
	 NyhbW5hPg0g8cOIM/H/cBglWaEeRVfVWWxyw9FNxSNFMscw6UdbikvsH+a6BeGTcb1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VJMzm+5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD1606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DD1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VJMzm+5y
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1981556eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 18:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793238824; cv=none;
        d=google.com; s=arc-20260327;
        b=JgLNvIL8vi2nP9aJWD5s6tnLiAfeGulRLWXe78ixv2FmRMMFomevU3CEFJayURa7rD
         guw+3XCbvzgQqOKwm2hCf33m7yCc4XIcaTxgcnNbmAG2IK3esSDgAWonG+g/iJr+qSr7
         fylR6s1o3SjT1s13Vvguq7APX+xCl7wEez4iHWRGpmtS/MO49/QmF1WJpDm+AuO2zZw6
         FxcNZJ//51x+ncyWHDv/XH1PIq58Ev+9LfktBQ88e8KYUzKzPT3fVevIA4DkwzH7VkTR
         UGJhLIxEkzPtMqkvnlzN10DTxjIOG2vcbzGGQpixVA0IMiu+iV4UWNV4tG8tIDUc0NpD
         OZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
        fh=l3vP5wnsErBOAkg7AUzd8HKFAP3E5ZYHta75iND1Fcs=;
        b=QoAb7qrwdlmqoek+aUz8/ahyUvvX+wVecq/9x1mTitksCcP9T+lhNb7jIFQNwAhlcC
         2Cf7WC3bLtwP6hXk8iSTga95bqektab5BKHwpxZoa7ttWzk86HwRjMBXzZoiSibGKGVe
         UwxwL6Nld9M1ajA8iLB6juvtb6p64420DsrwwjnPWWTeGGa4RhNKGZ3zHh/kv91ckFHL
         FYfUyad2o+07Qqt9s3qMCOF2BBH85JCS4CEMkZ3QNrFFmIdAZEhLuxl5+aGwRCNl4wmJ
         scFKTT1mwv9b7uQPbn3ZOHY2DM086aAckFIpim7NOHr0iy4txgun9e/tc/sZeTuV0LAW
         FoeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793238824; x=1793843624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
        b=VJMzm+5yD/wIGHVb+4KCC3ZIoBHwdyH59pUaKB4/gMct4nvQyIr2wWO9MLgEISmdE2
         uB/52VoBo5XGV2qq6eknNQRI7sDqvlynkCX6gXlIFvQ9WN8zW6sF6uMxmjYsaPrWwQDZ
         9aPPNiiCI6s9pR8d3WmkxbEvTLweIzjoXZhqaPA6zXQiku/+ST+0/BiWCNgIllf0nTbi
         4CuxBgFA36h3YyUTfk1wtsg4MxCFBsrDasyRaJJtGMdEtQyZtD5aylVNvwROoLnUWsWU
         110wWLj7m8gMQlWLPLjNm4F0y5lFAKBKm8U5+URAyRD4lfHsDAfBbvVaN5SFJxhMz66a
         wV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238824; x=1793843624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5xbfmRTc2/OENBILE/RMV+LpLgDZOf9nebMaXGSGAk=;
        b=UIdEYScZtowCm+mZ0nU0HAq4eLuOmZraTgLBnnTY96Uhh5S2zVI0UqEhNkzs7ETrR/
         OduHrjJtzh14caj8FtDVj4n6zureiSQJ2hrOw7lO+AZg6J93CrssIoP8i5/amvRvK/vc
         WsE1n/CANeVdQvMdwopd3bEdCTtRYOWk+2lmsyL+kH7YwKZl/FilWQVqRHst6Hy6qrel
         s27810Vrx37wt7VMlhiuhRCyTXLsQtEMipIWwBeGfxJ0bXR1Ctaq7DtnOVnLqxEBlwGt
         CL6H5TUee4pfwOkWUImF8gxckqFub/ITPUBFVQZnSiXyHEbn11CCuEohupvYhg72RMY0
         iAmw==
X-Gm-Message-State: AFq9FYLe/E6+OtxIezc0WLi9rFrNLU912P34JHuYnZnPC+46DauJYGXk
	2cJuxOtzvZYQk6Qkc6S+1mFRgvdz6v1QgqRdakCWeBz5PsJYhrt70rknnp1MXuRnMPjPbSx5JaT
	E5BqtR6lZkETLM49icuNSZ2kvL5mFI/DxG1Od56EY
X-Gm-Gg: AYBFou3FefMX3KfmB7AxhhmuWMaEx62LcQq1GIIZPI6k8Hvg4rWheBTz67k/O4JZMAi
	SoK0EkC4OocGbDkD8AeWm/b91GlVMgQyOZ1AxJIjB397yOnJMV0YuZ1lF67l7C3DWcRiMqd8R8n
	Yb8LCw7NeQ+okx7lKFWlHggqqzd0+URrZ2zjmyTKm0MuPYbA7GW5qT5xFdZiE2tZHa2NY19oC8h
	dA+O2Wxg5TTeVmoTjAjR1XbUwVgtD/g0izGH6GxPX586c02zDAmLZbLIydsALOf2nnhj8AfqH5Q
	1Sax11KX/uUGCxuz1/InMHCoYepKNZqV4EEDrDCzS8uWlIbsBJNBYzfutMhAc0r3P0eWw97+Ire
	mmXNXaUXzWR7unR4FjaHrPjLglgcqsNER/1auuqLMU1RRbUp/xmB9lDPKiJsVH7kkh34zFM9mkv
	6R4IjD3RuWplqXuuiaJJTneFaDJHvMC3p4t2u/wesHRRleZGaVb5PcXjJqMiLv1A5S/QtMKu7Xk
	NosWFwdJg==
X-Received: by 2002:a05:701b:205b:20b0:194:f017:5a01 with SMTP id
 a92af1059eb24-1a6d1f92f62mr5111887c88.42.1793238822982; Wed, 28 Oct 2026
 18:53:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027104701.296240-1-jiayuan.chen@linux.dev>
 <20261027104701.296240-2-jiayuan.chen@linux.dev> <CAAVpQUCBBaVmaZUv+D+a4anSbGSR_pKukYVXvRJRzSGVnjb2kw@mail.gmail.com>
 <eb85d54b-778e-403e-a5a5-56805b23b560@linux.dev>
In-Reply-To: <eb85d54b-778e-403e-a5a5-56805b23b560@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 28 Oct 2026 18:53:31 -0700
X-Gm-Features: AclHuK8XDsp5T4jIaX_MBCMs6DhlHPSgPvRq7TjuW4iyJKF7VUF6t-zq0kYU-QU
Message-ID: <CAAVpQUCHeydud7_NkMuUyK3tdNYLD9GrCGJiGQO6gV+r0-GuHA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/5] ipv6: restrict gc_elasticity to 31
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Willem de Bruijn <willemb@google.com>, 
	Maoyi Xie <maoyi.xie@ntu.edu.sg>, Jiri Wiesner <jwiesner@suse.de>, 
	Gerd Rausch <gerd.rausch@oracle.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 6:47=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 10/29/26 7:58 AM, Kuniyuki Iwashima wrote:
> > On Tue, Oct 27, 2026 at 3:48=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
> >> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
> >> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
> >> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
> >>
> >> ip6_dst_gc() reads ip6_rt_gc_expire into a u32, but gc_elasticity has =
no
> >> bounds at all, so writing >=3D 32 shifts a 32-bit value by >=3D 32 bit=
s, and
> >> a negative value gives a negative shift count. Both are UB:
> >>
> >>          val =3D atomic_read(&net->ipv6.ip6_rt_gc_expire);
> >>          atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elas=
ticity));
> >>
> >>    UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
> >>    shift exponent 32 is too large for 32-bit type 'unsigned int'
> >>    CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREE=
MPT
> >>    Call Trace:
> >>     <IRQ>
> >>     dump_stack_lvl+0xc1/0xf0
> >>     dump_stack+0x10/0x20
> >>     __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
> >>     ip6_dst_gc.cold+0x15/0x1a
> >>     dst_alloc+0x4e0/0x620
> >>     ip6_rt_cache_alloc+0x189/0x7e0
> >>     __ip6_rt_update_pmtu+0x68e/0x1160
> >>     ip6_update_pmtu+0x30c/0x3a0
> >>     icmpv6_err+0x1fa/0x330
> >>     icmpv6_notify+0x303/0x770
> >>     icmpv6_rcv+0xc12/0x1670
> >>     ip6_protocol_deliver_rcu+0xb4a/0x1520
> >>     ip6_input_finish+0x19c/0x400
> >>     ip6_input+0xd4/0x240
> >>     ipv6_rcv+0x1fd/0x330
> >>     __netif_receive_skb_one_core+0x118/0x1c0
> >>     __netif_receive_skb+0x21/0x150
> >>     process_backlog+0x37e/0x1200
> >>     __napi_poll.constprop.0+0xa5/0x5e0
> >>     net_rx_action+0x4c0/0xf70
> >>     handle_softirqs+0x204/0x9b0
> >>     __do_softirq+0x10/0x18
> >>
> >> Make it a u8 and reject writes outside 0..31 with proc_dou8vec_minmax(=
).
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Cc: stable@vger.kernel.org
> >> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> >> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >> ---
> >> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
> >> Iwashima.
> >> ---
> >>   include/net/netns/ipv6.h | 2 +-
> >>   net/ipv6/route.c         | 7 +++++--
> >>   2 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> >> index ffda15318be59..aefce37c04a4f 100644
> >> --- a/include/net/netns/ipv6.h
> >> +++ b/include/net/netns/ipv6.h
> >> @@ -25,11 +25,11 @@ struct netns_sysctl_ipv6 {
> >>          int ip6_rt_gc_min_interval;
> >>          int ip6_rt_gc_timeout;
> >>          int ip6_rt_gc_interval;
> >> -       int ip6_rt_gc_elasticity;
> >>          int ip6_rt_mtu_expires;
> >>          int ip6_rt_min_advmss;
> >>          u32 multipath_hash_fields;
> >>          u8 multipath_hash_policy;
> >> +       u8 ip6_rt_gc_elasticity;
> >>
> >>          __cacheline_group_begin(sysctl_ipv6_flowlabel);
> >>          u8 flowlabel_consistency;
> >> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> >> index 94e5ef1c4f83e..abc8b811cd423 100644
> >> --- a/net/ipv6/route.c
> >> +++ b/net/ipv6/route.c
> >> @@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struc=
t ctl_table *ctl, int write,
> >>          return 0;
> >>   }
> >>
> >> +static int ip6_rt_gc_elasticity_max =3D 31;
> > as you need v3, s/int/u8/
> >
>
> Hi Kuniyuki,
>
> proc_dou8vec_minmax() put extra1/extra2 into proc_uint_conv(), which
> reads them as unsigned int, so the max has to stay an int like
> tcp_syn_retries_max and friends; a u8 there would read
> three bytes past the variable.

Ah exactly, then please use unsigned int.

Thanks
