Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11D451071
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387325; cv=pass; b=I8gNUdgDT1kram3hhsB1Ywdgvd0e/yni0NI5JdR8RZryJBcTWas+9ovlPvxFN29S1fvDSkKpvOjGEPjFSXvWI+tmnf+UmSlXaDXR7I8Du2fsV2/npZOu3PSjb/mIpdVxBHdrrwwQJtlbOZAK72iuPfyi88en4uWoozIPAteAUIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387325; c=relaxed/simple;
	bh=WDEUVrdLkKvz95MFCadBRmBNiLDw6jCMZuJuM4hcvnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuC0wikp/j2gVKDVYGWGBeGJr4RKeclUBoCptSEwb+wyJlADXzBvBVPwQ2Yj8rLvXLuz4by8Cft8XsmqxsmCGL1go9vWMMQC/lfYH7wi/yijHXJA+edL1/tiG+kYkq0v7wBJaDSSHWV+nUtNe2I8c5yI41okDHUI20qqA2rNZZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKhIs629; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKhIs629"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so1564751a91.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789387315; cv=none;
        d=google.com; s=arc-20260327;
        b=OL8nHolGrZd59GQWQ7Hd7jLTaPbqtXT4T44Jz0b7ujyhxB2GG8u8ps7yhr47y7N2EK
         RUbLFHKJcwMpZ2V5SPzYjk9bALRVN2YG5cquVHuROhweKny5XwDZ5lshfIlElUzG6jxL
         jzU/yFUn/HwtAWdHKoSFfG7tpH4uUZEZ0FZRhd3Vq8LNcAWUC+XJNT89S08mVFZAB7Ir
         EjHjHcQDcxq8tSVREfq0774TqQhXcq7I9fB/NstSUryH1ALLrUTlFUwwvw0CpCWIEJyq
         JvbkHO3ZbWyCd2E8DkjdkaX6FLUtgPoSOxTVK9X95sYlTotApT+eifKm0Iyr/rDYipyH
         6uUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mS7vtDPxxU2homzDGl7yWJhS95lRXjFbALRbsqqxF0=;
        fh=9N4iTpEtelHMyAkzF6C69JyUizWqhHL+Xp32KnaICVQ=;
        b=cz0CR5vxKUj2hTIiqYYbfs4bQC7BA8Q6MjY66rW3JwT7cYmWVhTog8FCm+fGm3pdrQ
         DBAUwIfNBPyxKPmRR5xIK0Mdz6u6gh7KHvINngJINIRLxQPLgCtd7lBzV91l1LKAhF5p
         AULn7RiZJK5FQF5NpMR+JKMbtvV/XamKh+gTxMLXOoCuIlE0S30TMQjucR5Pm4ZoxUTb
         2KE9sm+OvlkXiKu8tG9HLOlvrQxi3EWL4l2PHJDf/rqW3sY9vgT1STAdhSVDklwPmW1R
         vBYugXKWv9PVBU7fPXnLMBNKLJM7wiBT4hrAe9sPekDyiBVBdNMMZH+obxt74TnKQMjG
         p85Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789387315; x=1789992115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+mS7vtDPxxU2homzDGl7yWJhS95lRXjFbALRbsqqxF0=;
        b=WKhIs629A218GZQt3Hy92H/3HiwH8phVF8Icw9NquPk7R16RI7uKwI0BFWJEFu+7zQ
         Aw4PJpGoSf4blMElVEicZIN8iSEZ5bsBRPV827d9ape48ebvTXVfkBPsMiQRuRNKzrFT
         k2hnA25pjb2YWeQb9hdS0jJt8rvwDY4siVyAgMoBCFNFsHDR/vdeXq+BtnNUcnHHcAYw
         BRXGd3mjqyXx23w7c4Rl8K+p84UU4drDsKAmUFrvyzNNwNumCjK/w50ima7TsCcPtdlD
         an/mPKIQAJhOxkjmZBK2Nq1kU3FskeGrsA1smQbVyBYIF/9ylh/h6ay0G0nkVTcbO97r
         1i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789387315; x=1789992115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mS7vtDPxxU2homzDGl7yWJhS95lRXjFbALRbsqqxF0=;
        b=eK3K+kl9+o+IjZVCK91FH1tH8OHiAZgotSuVrxIwR7RucLakHOozfoe9fNVyga3u1o
         Gtu9PXGCNr0oYtBaj0zkMREN8tA22Fl8Y/C+ss4p6X5721/DNsrqyn8leoLNj1Htx9z5
         gZjn+iDVeptTTabvWC3lGxwdx2E2aeDe57b+DikBu8emNFRKLQhV5Eiz8ponV8ploskY
         /YhykfbzWrkEq6dPhglR3aXAbd56HoLICrxd6UYkIkQNS2ZSKXuGRWfqhwf5FYYWOwnf
         8j+H9v+sxAWbgAmqmWWhUToTa9180HyhwmRR2F8HYK75C7hSCkzt6QzqLDVMby5/jiLI
         bkVA==
X-Forwarded-Encrypted: i=1; AKwUvByPukfkJBkxm1ZROH3GInd8y6mZYikRAgXfVvQ9r0ezpW13/rOKMG7IXXWr77mgiE+mdov0ffU=@vger.kernel.org
X-Gm-Message-State: AFuF++k8CrGA+oeVcq0j8/SoeBNN0mugxzzHvBdmsQwXm08jDd4FgggQ
	aC44pikWYV9p8BbM3tL6Jdc1ORgcTbOkWB2K8Cb08aOo04Hb5yNIeYsWDmM/aYm5h01Cox0aOwm
	U7dERP1vtn+jovFsGdGwM81GSmRzeeUY=
X-Gm-Gg: AYBFou2Ua4ta01kRbMGMbSF8UIx3XoXWtKBjwuTyxuumLw913AIOFmgA2MxNDWHMWOJ
	/wlXDNkTG3R4DCDRY7LNjmJjC4tQjzlYOiSNpz8G7zZNd/9ofBCrUED7Pc/8bBczF3FoASDtGfa
	UV14+y7l+9th48wdyjEAv1rUQnqDxy1mHA15gPnv6I3++VW8tTQ0SsLZA9VTAfcO/t0xy15KB3k
	0/MLGPw/XPh9owCJDkuD0BBWybRR1NHh8JZXF9zqX3suqc6PCpEcUrCOmFF0dP63USVFS0PdUBA
	ych4lO+PnX1yypxrrBWFmdJQ425IolYeiaUYbYhzR1kXVPm3UjyFWhi0UOdJJg5OhPc=
X-Received: by 2002:a17:90b:2249:b0:398:c3c9:d0ae with SMTP id
 98e67ed59e1d1-39debdd2283mr4798231a91.0.1789387315260; Mon, 14 Sep 2026
 05:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908060410.3982-1-nashuiliang@gmail.com> <20260908133636.2ea807d9@kernel.org>
 <CACueBy4BvJ6E0RuUDsQmwPq_zt9Xh6T19DOAkA5MW-uU1yNpKQ@mail.gmail.com> <CANn89iKYQMPm_LyYY4v48QmoFc0MwkkKQwggd_BLGDJL78=8qA@mail.gmail.com>
In-Reply-To: <CANn89iKYQMPm_LyYY4v48QmoFc0MwkkKQwggd_BLGDJL78=8qA@mail.gmail.com>
From: chuang <nashuiliang@gmail.com>
Date: Mon, 14 Sep 2026 20:01:44 +0800
X-Gm-Features: AcwNN1UkEpUCQ5OcMo1LKsk15DqENpfvJz-tmdqzx1eSl3HXKATXLGI1WggOLYk
Message-ID: <CACueBy4u-2yHHysZvs_a=VQLe4PtY9-qjkdZ3gFn_eVKmyspOA@mail.gmail.com>
Subject: Re: [PATCH net-next v9] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 12:14=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Sep 12, 2026 at 8:50=E2=80=AFPM chuang <nashuiliang@gmail.com> wr=
ote:
> >
> > Hi, let me restructure the issues.
> >
> > > 1) Also not sure why you're trying to touch RFS, the change only help=
s
> > aRFS and you could avoid bulk of the refactoring issues.
> >
> > The scenario is similar to the one described in "[RFC] problems with
> > RFS on bRPC applications"[1].
> >
> > I attempted to enable ARFS on a Mellanox CX-6 NIC. While it performs
> > well for simple workloads, performance degrades significantly when
> > running a bRPC[2]  workload on a 2-node NUMA machine. After tracing, I
> > identified patterns that ARFS/RFS fails to handle efficiently:
> >
> > - Multiple threads use epoll to read from the same socket, causing
> > frequent flow updates in sock_flow_table.
> > - Threads reading from the socket migrate frequently between CPUs.
> >
> > I tested a PoC version using a bRPC service, utilizing funccount [3]
> > to monitor execution frequency and perf top to observe hotspots:
> >
> > Before Patch
> >
> > The mlx5e_rx_flow_steer frequency is over 380k/s, and queued_spin_lock
> > is a major hotspot (6.30% in perf top). The application also suffers
> > from a noticeable drop.
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer              387594
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer              390142
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer              386694
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer              389094
> >
> > # perf top hotspot:
> > queued_spin_lock                         6.30%
> >
> > After Patch
> >
> > The ARFS update frequency is significantly reduced. queued_spin_lock
> > is no longer a hotspot in perf top, and the application's overall
> > performance has improved.
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer                      43
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer                        9
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer                    207
> >
> > FUNC                                     COUNT
> > mlx5e_rx_flow_steer                      26
> >
> > > 2) You put a very fast path function out-of-line, why ?
> >
> > The reason is that tun uses sock_rps_record_flow_hash(). When I moved
> > all rps_record_sock_flow and rps_record_cond modifications into
> > include/net/rps.h, it triggered the following compilation errors due
> > to symbol visibility:
> >
> > ERROR: modpost: "cpus_share_cache" [drivers/net/tun.ko] undefined!
> > ERROR: modpost: "cpus_share_cache" [net/sctp/sctp.ko] undefined!
> > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> >
> > This arises because the patch uses cpus_share_cache() to limit the
> > RFS/ARFS update frequency at the LLC level. To keep this in the fast
> > path, I could move cpus_share_cache() to
> > include/linux/sched/topology.h.
>
> Hmmm
>
> If the LLC affinity check is performed in set_rps_cpu() inside
> net/core/dev.c before triggering ndo_rx_flow_steer:
>
> net/core/dev.c is built-in, so it can call cpus_share_cache() directly
> without any module export issues.
>
> sock_rps_record_flow() and sock_rps_record_flow_hash() in
> include/net/rps.h remain 100% inline, retaining the zero-cost static
> key NOP in the TCP/socket fast path.
>
> No exports, no refactoring of tun.ko or sctp.ko, and no fast-path degrada=
tion.

Great idea, this indeed minimizes the changes.

Although there is a slight semantic difference compared to
net_hotdata.rps_sock_flow_table, meaning the CPU recorded in
`sock_flow_table[flow_id].ent` might not perfectly align with the one
used in `set_rps_cpu`. It is still the least intrusive approach.

How about the following simple change?

diff --git a/net/core/dev.c b/net/core/dev.c
index 3a0dd1f98084..7c513bf14221 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5236,7 +5236,7 @@ static int get_rps_cpu(struct net_device *dev,
struct sk_buff *skb,
                 *     have been dequeued, thus preserving in order deliver=
y.
                 */
                if (unlikely(tcpu !=3D next_cpu) &&
-                   (tcpu >=3D nr_cpu_ids || !cpu_online(tcpu) ||
+                   (tcpu >=3D nr_cpu_ids || !cpu_online(tcpu) ||
!rps_check_llc_affinity(tcpu, next_cpu) ||
                     ((int)(READ_ONCE(per_cpu(softnet_data,
tcpu).input_queue_head) -
                      rflow->last_qtail)) >=3D 0)) {
                        tcpu =3D next_cpu;
