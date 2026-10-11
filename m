Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9139D6D6
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762579; cv=pass; b=hDIyyzKG7fBhkS2tKVz04YnsRU1CGkG5/IPVsdA3u96lafYrdw8GM2Pkk823s/xVMGf1oaeiGzRNsqs3P0Q8S4O1gX2jItT1QlfC376FyW0yR3RFW8JjR6AN0hpZdVnWY7+2yMt6/4FOSzZwk0IHns2/dyf3boDtq3ZRrDj++tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762579; c=relaxed/simple;
	bh=HrfKmn9qs6fAPDd1wR5ofdTOe/bVER6zo8Nme2pwZT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J85Qg4CKXP0h5vkxQ3MXlWhjMpo6T6679QJWonOdkVLTUy0I99FRqrzSj1ien7mafD0UmClzwLT+uC3lXVaBetJyaKUzvIQ/YU3Wye4l0DnTw6IztGCSRnxWZGcsjajjKwTyG49y0pU+dphktbu2QaAA/aFIGaZoA3zr7IClEO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Q5zAirmr; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Q5zAirmr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88aea027391so569180b3a.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 16:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762576; cv=none;
        d=google.com; s=arc-20260327;
        b=n7RoMl1C1AHJdRP8STmRzymvqfzC/FPutN7DcNghJ56cMzsCtKP1WR45ATNUPHfdKQ
         n14S1l2fYJwuTDJQ5NZljymfR/3m3VW04o2GfwdtK6aK4VgTyEiCLhLjZ6BHFoWoHW5g
         vEV8I7Q31qKEk5KurRydWRjQPqFQvnXzOdZQ0smSVVd8cjGZQYgwiYB66mxzGQiWwMxL
         yqP9SZvKTOURT6laAsI/LYfP05h7FSpFUeIo2XVe+yfEiIbY7biVB833As+tP23Z4wSK
         lczZXicQqVZLmUKJ8l6HMiiydNiRV2uX6grKZeHNS7Pt4f07HEHf7DThS1GxOjqzqcZL
         AeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xxVsFCn2koVdZeQBwo5grIeecj1lz6W9qtXamdCYuig=;
        fh=NFy4m0wmh36dq8lMzR7nYbpqRPLOkHsJEjWAxh8zqww=;
        b=T888c+Ap+XNEhn3XTjoqs8ORNV8LX3Am7yLUILsur4q08Q2oRRJuPQ4LvfKYxeA6sv
         dYhDmfjUg9JHuy2iza9EBMJpn3pPLkMytTs3B6EF7bvlWJ55IJ81zUK89eBVdgsCBdJ2
         tEff0pQIYKYPl7Udcy1fi9bSMBQc2mcAjwLSvUOJ77lmJ2gVAsnmzxIzQ/ZxW+iX2XKn
         Tb/Vcj0FYMOw63JcUTt0j+Sc2yhRVDl8UTr5g6w5CqWPYv1ZqbRsAdIivVXdrE2deGZ+
         9Rv3TKNwm+McSde2sEfi+XyQuSLHU3DjNUqXwr16G1EY9YN28B3MvHWnwMdZ6WRRNa1/
         o09Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791762576; x=1792367376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xxVsFCn2koVdZeQBwo5grIeecj1lz6W9qtXamdCYuig=;
        b=Q5zAirmr+gXzC0ETmZMqiyZVkzoc8f23J5VyDIbk6pam+NKhMqUp7IEH7n4xhPywwm
         BcKTLkGmczehSN09PkvFdxii/foh5U9U7E2EmWzjwK+/Neoe8SUbnqRec4u8X26Sxl09
         xfKjruH8u0gD4CurZ2dcL6AhStsMVWKpiuw0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762576; x=1792367376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxVsFCn2koVdZeQBwo5grIeecj1lz6W9qtXamdCYuig=;
        b=gWeqR8XJ42vgE2DsfUADSf9FStvP8PxjFDgug/0YFpaxrKythiypE9+PV3TUP/xeRI
         p3kg8KXfCy6sM+Q4KpiwYjgZdYy2koUJREJ7cbJjEi5nuXC28wSOCS5vkTYxc1cRxKf8
         sgISCmlyvxHyF/38qLgBoXY9WkFJVfG9ExHefU0FDnZzT1GqvRX+GlGIOSaFXlcTYSKY
         48saBMRlPX1072LaIc3SwRvnhHG/yF3/3iZU3yxBXnXAg72PuHQmzkpNV9zl2+WTcOrC
         JD0HFtku5oo/dsGkRTCTkPIfmN7+8fQusOh+15aJKthAeJGBjVOlmLZQ6YeHOoLbuIa/
         YCdA==
X-Gm-Message-State: AFq9FYJDcnBkhNZaax7HIdB1ffQAjsJx3MVAbVWev/P0FdjOwvfMjfMB
	cZ6Ml/1tmJt2VG/aR5OV/ym8fZsW6F8hCGuBe5G7vREFny0ZHsHiBzXI+MuQdLNilQRs+CFdM/m
	CuA6ARCV/AixiknC5ggGoHlKrTai/GTUFkWZXxgKp
X-Gm-Gg: AYBFou24I22ylQMFhkepuyPn8Qs49ub6XEM9qDdY/rO9YwSgfHt51rwP3nb09GdfpLZ
	CTKaJWLtF7m1P0RyBXtbZUDrKyvUlryVPlxiIlInVEor5RkM5NAAq6S2B/EKMQKk1NRCwAr9wfv
	onNG2mvMF1exm0bYjRvF+LqUo1Cf72PVuyHWtNEkXZ05qzwordXvmog/yqyCYtKC0LlHysjVz1i
	fWrCqos/ILt8v3J+jxkCFVYEzdG4o0g4nsECqaCvHzo/Ltwdlo9Ry79APmr//huwM1uDvIa7cPb
	h2J5SyiUE+wtzRi/h6MIM3RGi4MbF/Nvw8SpYbOKSGc9Cu6KlnDQypsQhEgCrra58v7R4jH2dVL
	xJmegIzgR6vEZ1xU9dwXFKvaED/p/T7FBYg==
X-Received: by 2002:a05:6a00:9284:b0:890:e1ff:3bac with SMTP id
 d2e1a72fcca58-897c3ef925emr6357823b3a.8.1791762576250; Sun, 11 Oct 2026
 16:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-PYC7.v2.20261010165947-4@mojatatu.com> <179175260755.434549.1147971569759277746@kernel.org>
In-Reply-To: <179175260755.434549.1147971569759277746@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 19:49:24 -0400
X-Gm-Features: AclHuK8d5drO7j5c0DGAq8NuaCDnyn2xqFpgj8CthGJvTQntklzqnOT6cxSg2Cc
Message-ID: <CAM0EoMk2X9JdHUop7yh0s6jphZXF+LJFZ+Fnfy6LHxmiLFVpoQ@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] selftests: net: exercise dev-bound cls_bpf on
 shared blocks
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 5:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0 (2)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says the first subtest checks that "the
>   program attaches to a shared block owned by its device, and the filter=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the late-
>   join subtest (block 30) runs a core offload-accounting imbalance and=E2=
=80=A6
> - [Low] This problem wasn't introduced by this patch, but the same-
>   offload-device subtest hits a netdevsim state-tracking defect.
> - [Low] This problem wasn't introduced by this patch, but if one of the
>   new subtests fails, a netdevsim device can be left behind.
>

Unless something else which is substantial shows up I will not be
sending an update to this patch.

cheers,
jamal

> --
>
> selftests: net: exercise dev-bound cls_bpf on shared blocks
>
> This adds test_tc_shared_block() to bpf_offload.py. The test attaches a
> device-bound SCHED_CLS program to netdevsim through shared tc blocks. It
> covers four cases: attach on a block owned by the bound device, rejection
> when a foreign device is a member, rejection of a foreign device that
> joins late during replay, and acceptance on a second port of the same
> netdevsim device.
>
> > diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing=
/selftests/net/bpf_offload.py
> > index c856d266c8f36..8c1da9b51be5a 100755
> > --- a/tools/testing/selftests/net/bpf_offload.py
> > +++ b/tools/testing/selftests/net/bpf_offload.py
>
> [ ... ]
>
> > @@ -629,6 +661,111 @@ def test_spurios_extack(sim, obj, skip_hw, needle=
):
> >                              include_stderr=3DTrue)
> >      check_no_extack(res, needle)
> >
> > +def test_tc_shared_block():
>
> [ ... ]
>
> > +    start_test("Test TC shared-block dev-bound attach...")
> > +    # The pinned program is dev-bound to this device; attaching it thr=
ough
> > +    # a shared block must succeed even though block->q is NULL.
> > +    sim.tc_add_block(22)
> > +    # err is kept (include_stderr) for post-mortem value on a failure.
> > +    ret, _, err =3D sim.tc_add_block_filter(22, bpf_pinned("/sys/fs/bp=
f/tc_shared"),
> > +                                          da=3DTrue, skip_sw=3DTrue,
> > +                                          fail=3DFalse, include_stderr=
=3DTrue)
> > +    fail(ret !=3D 0, "dev-bound program rejected on a matching shared =
block")
> > +    fail(sim.dfs_read("bpf_offloaded_id") =3D=3D "0",
> > +         "dev-bound program not offloaded on a matching shared block")
> > +    sim.tc_del_block(22)
>
> [Severity: Medium]
> The commit message says this subtest checks that "the program attaches to
> a shared block owned by its device, and the filter teardown leaves the
> device unloaded". Is the teardown part checked anywhere?
>
> After sim.tc_del_block(22), nothing reads bpf_offloaded_id again or waits
> for the flush. sim.tc_del_block(30) has the same gap. So does the
> sim3b.tc_del_block(50) / sim3.tc_del_block(50) pair, which covers the
> unbind remove replay and the last-member block destroy.
>
> The tc_del_block() helper also ignores failure:
>
>     def tc_del_block(self, block):
>         tc("qdisc del dev %s clsact" % (self['ifname']), fail=3DFalse)
>
> The only check left is bpftool_prog_list_wait(expected=3D0) at the end. I=
t
> runs after simdev3.remove(), simdev.remove() and the rm of both pins. It
> counts programs, not per-port offload state, so it can't tell an unload
> caused by filter teardown from one caused by device removal.
>
> Suppose the remove replay through
> cls_bpf_reoffload()->nsim_bpf_setup_tc_block_cb()->nsim_bpf_offload(ns,
> NULL, true) stopped clearing ns->bpf_offloaded:
>
> For blocks 30 and 50, the only sign would be the
> WARN_ON(ns->bpf_offloaded) in nsim_bpf_uninit() in dmesg.
>
> For block 22, the failure would show up later as -EBUSY ("driver and
> netdev offload states mismatch") on the block 30 attach. The test would
> then report it as "dev-bound program rejected on a matching shared block"=
.
>
> Could a check like this be added after each tc_del_block() for sim, sim3
> and sim3b, while the devices still exist?
>
>     fail(sim.dfs_read("bpf_offloaded_id") !=3D "0", ...)
>
> It could also be worth checking that sim3 is still loaded after sim3b
> leaves block 50. Otherwise, the teardown claim could be dropped from the
> commit message.
>
> > +
> > +    start_test("Test TC shared-block broadcast to a foreign member..."=
)
> > +    # Add an independently backed device to the SAME block before the
> > +    # attach.  The program is bound to sim's device only, and the offl=
oad
> > +    # path fans it out to every member, so the attach must be rejected=
.
> > +    simdev2 =3D BpfNetdevSimDev()
>
> [Severity: Low]
> This is a pre-existing issue, not one introduced by this patch, but can a
> failure in one of these subtests leave a netdevsim device behind?
>
> clean_up() loops over the same list that each removal modifies:
>
>     for dev in devs:
>         dev.remove()
>
> and BpfNetdevSimDev.remove() does:
>
>     def remove(self):
>         super().remove()
>         devs.remove(self)
>
> As a result, every removal skips the next entry in the list.
>
> Here simdev and simdev2 (or simdev3) are both alive. A fail() in the
> broadcast, late-join or same-offload-device subtest raises before the
> local simdevN.remove(). The outer finally then calls clean_up(), which
> removes the first device and skips the second. The second device and its
> clsact qdisc are left in place.
>
> Looping over a copy of the list (for dev in list(devs):) would avoid
> this.
>
> [ ... ]
>
> > +    sim.tc_add_block(30)
> > +    ret, _, err =3D sim.tc_add_block_filter(30, bpf_pinned("/sys/fs/bp=
f/tc_shared"),
> > +                                          da=3DTrue, skip_sw=3DTrue,
> > +                                          fail=3DFalse, include_stderr=
=3DTrue)
> > +    fail(ret !=3D 0, "dev-bound program rejected on a matching shared =
block")
> > +    ret, _, err =3D sim2.tc_add_block(30, fail=3DFalse, include_stderr=
=3DTrue)
> > +    fail(ret =3D=3D 0, "foreign device joined a populated dev-bound sh=
ared block")
> > +    check_extack_nsim(err, "program bound to a different device.", arg=
s)
> > +    fail(sim2.dfs_read("bpf_offloaded_id") !=3D "0",
> > +         "replayed program loaded onto a foreign device")
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the rejected join here
> seems to break the core offload accounting, and these assertions can't
> catch it.
>
> When sim2 joins block 30, tcf_block_bind()->tcf_block_playback_offloads()
> with add=3Dtrue replays the filter to sim2's callback. The callback rejec=
ts
> it with -EINVAL. Because the filter is skip_sw, tc_setup_cb_reoffload()
> returns the error and the playback unwinds:
>
> net/sched/cls_api.c:tcf_block_playback_offloads() {
>     ...
> err_playback_remove:
>         tcf_proto_put(tp, true, NULL);
>         tcf_chain_put(chain);
>         tcf_block_playback_offloads(block, cb, cb_priv, false, offload_in=
_use,
>                                     extack);
>     ...
> }
>
> This sends a remove to the same sim2 callback, including for the tp whose
> add just failed. nsim returns success for removing a program it never
> held:
>
> drivers/net/netdevsim/bpf.c:nsim_bpf_setup_tc_block_cb() {
>     ...
>         if (ns->bpf_offloaded !=3D oldprog) {
>                 oldprog =3D NULL;
>                 if (!cls_bpf->prog)
>                         return 0;
>     ...
> }
>
> So tc_setup_cb_reoffload() calls tc_cls_offload_cnt_update() with
> add=3Dfalse. The filter's in_hw_count drops from 1 (sim's real offload) t=
o
> 0. TCA_CLS_FLAGS_IN_HW is cleared and block->offloadcnt drops to 0, while
> sim still has the program loaded.
>
> When sim.tc_del_block(30) runs, the unbind decrements in_hw_count again.
> The u32 wraps to 0xFFFFFFFF and stays there until block destruction calls
> tc_cls_offload_cnt_reset(). Until then, tcf_block_offload_in_use() is
> false, so tcf_block_offload_bind() skips its "dev has offload disabled"
> check.
>
> Would it be worth also checking sim's offload state and the filter's
> in_hw flag after the rejected join?
>
> The same remove-returns-0 behaviour can already be reached through nsim's
> -EBUSY add rejection path, and nfp's callback has the same shape.
>
> [ ... ]
>
> > +    fail(sim3b.dfs_read("bpf_offloaded_id") =3D=3D "0",
> > +         "program not offloaded to the same-offload-device port")
> > +    sim3b.tc_del_block(50)
> > +    sim3.tc_del_block(50)
>
> [Severity: Low]
> This is a pre-existing netdevsim issue, not one introduced by this patch,
> but with this teardown order the program's debugfs loaded state is wrong
> while sim3 is still offloaded.
>
> netdevsim tracks loaded state in a single per-program boolean that every
> port shares:
>
> drivers/net/netdevsim/bpf.c:nsim_prog_set_loaded() {
>     ...
>         state =3D prog->aux->offload->dev_priv;
>         state->is_loaded =3D loaded;
> }
>
> sim3b.tc_del_block(50) replays a remove to sim3b. That runs
> nsim_bpf_offload(ns, NULL, true), which calls
> nsim_prog_set_loaded(ns->bpf_offloaded, false). This clears is_loaded
> even though sim3's ns->bpf_offloaded still points at the program.
>
> Until sim3 leaves the block, bpf_bound_progs/<id>/loaded reads as not
> loaded. The WARN(state->is_loaded, ...) in nsim_bpf_destroy_prog() also
> won't fire in this case.
>
> The existing XDP multi-dev ASIC tests already follow the same pattern.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-PYC7.v2.20261010165947%40mojatatu.com
