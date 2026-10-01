Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18C48A8C6
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886227; cv=pass; b=Wxn0aW4tkx4TFdBen7AVzdApnc5OCcyMxLiU+hCSbbgTTyZ7Ah7MohRW9KYnwvmo10Xngvf+HCoQOLB2UOd5WOp+V+8Et+vn9WjlJJ90WJTYSv+oEaq59bsYJj1eMY8X1AYO+THQxvyG0OQ59HeTg4lj+Tmsg5sAqwmqYqce11Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886227; c=relaxed/simple;
	bh=HTVsZ29+FqJ2VksrIZ9ce4EIkKgFQDGCIXN8U46NU4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lo3T9FLZ2KiKDW86Z9kCPV0UOraDjinXFDkANfxxl7tjJaWkjw3iFIN5tJjp7wgQ33AQSorFKKj+ARYOrLpGsWOT2LfgYHlhlaMnPutLDwAs0JRV5UPpbSwwXstOEidyE0N78Vri0UFnmeR2FYhDhM5B0tHmRESxiO3zwTsz3TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J05Iks+V; arc=pass smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J05Iks+V"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48affb828f1so2255229f8f.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790886224; cv=none;
        d=google.com; s=arc-20260327;
        b=LtkMUN7Ok12X8eEGACqFZSG0vGLIozMC8eAzK8SMCnxGX5gHep7VGgqkTAP0dHQ474
         6efiQQE2w1QmE2l7d6+6NkNHIBsF7S3KT/HTWRU+VkeZHKmjIreRv3VSrSJE/5uM1rRY
         qF+TUtjEb39YJxGfuDMsMhW/0lpcemvtc6JNdQCa5+/iQD388tbkBq/VfkXdDkU+vw5O
         kZFX7HAAlECglPTg43138lqWwEKY4pL6Dp+pmJI6SbHNqCxiYELBrG/Wk3vgVZkztpiU
         UYwdR1Jf2giubM23TIVsdSPRjjmDU0kCIB2myHo+camVid6epb4P4HM6MMHH1Jy1+Lon
         rJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fD/v0ksX9YszAYMybV9cxq2uONcPSZKXR91ifx8PQA8=;
        fh=sgMlnpPIkoatpKB1xJDHQICPZqesERPploa6LoXqXLk=;
        b=nRkSSKcUAEVwFmHiPjLqujFJlCEsVfIKxtUKwrW14rTZMjOm+56kUreZr6VESibu0O
         N/8oETGDsnRgn06gtpF0tlccEoCFjen9VqX/C49EqdFJO/ZTzZiyJQt45JB8aVp/Km3H
         u7TRxIHtHBKGy9D749DOuMmY949z6yhyZ8FRrF+uev0G65S2O8TepS3aIQQzBrfrIuoO
         Nq54Yarym1RUs2JuO1Ka+ZI714nAwAO+NoJIKMpoiufOnrSBGsbFrXiZ5Go9wHXq6kVH
         x/WeZrTjpOlE9dfmKbpdETExEPRSOQhRwwJOyuw4Vl+/WkzIrjitcuhxJFrr3wMdLDZN
         ++9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790886224; x=1791491024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fD/v0ksX9YszAYMybV9cxq2uONcPSZKXR91ifx8PQA8=;
        b=J05Iks+VDLMqUk/8m0iF/Dic1jYJ3YloDSl+wnXHUrGHintIJsvdy3cJP6t38V10Y+
         NmyCHT+aMdVNEeM6iZw+gBllc6GdfVvmEV8NTjuV78X0+tAGFH421jALMMZ6JhWbRC1q
         OCqFzURuazn8Jnm2KapqSeIIvzNg6ymALbTZLrOJhk+q4c6dt/QNAqu6vpuNeOhRsTCa
         F09ro46yd1jTtUb0dhqkKde20qodc5Wtt15lHrR+Z/Wh1AFIEZ/DxhB7T6B/D4eNGdP2
         DLIqVYc8VoPprNJiqMBkiTe/Jf9W3OCOJxKuZUeko0DTKMEFwUC0pvSb0xgDLSkHe8SW
         1a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886224; x=1791491024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fD/v0ksX9YszAYMybV9cxq2uONcPSZKXR91ifx8PQA8=;
        b=FF1v4E6SXnb15exYU3RjBMfvALPJqz2NgT9/EehsqXHKMB/Z7bCtHS9CV4dc00aBdS
         iynVl8cNz6bTeRvoind3Q773KQ0NSOP+LztjasUj1xiQZBdMyLmL6qQnTnjNNF3mFaa9
         VsE7JINWPrNZ9Au1+9nj4kR7n/Wx5EJ/K/7RJLpRBpvK0cSaPPIiFJEW0DYLl01ZEXJG
         4zikUcUEXdNbNC6q0TbbxIne/ZMZyZRN6v23X6qVJ5jUEsNRTwTGWkd5NrR22hAg/c9+
         mi5Ctl/e6jDe4j6srXwmr7CxaocpWUyz9EfC1ZUIVVJz5IHx0oJrpelNcPMMPoQJ1V71
         xHdA==
X-Gm-Message-State: AFq9FYJerSmgvQcdxegmsLJwLAYOxtZHJ1R87oCtO2LUjZq5Kf6smnkm
	De2IKi+PLtqgG4QkMHLil8idZ/8R3p3aWViw5zdIHSRiXUnUKaerVIAqh3qnHwL1sqxVr3+jNPz
	vsPsJgTk5bOea99bksA5lQ72xCmO3lHU=
X-Gm-Gg: AYBFou0W+H+4C1l4+DzhvUjvrAbBU0aH0igAmysvAW5cwTJee4YnVg8heAA7lfE4tAU
	wAudauxOqfMt9BMs+BqWoZlLZGv36WLhlnoAcbH6oZQDxgFl932jEJKrcsjzddV+1o7QyineO4y
	156KFoSigMNuXHVfMurJ/Ub3/V3XbfeHIxSkNWltBijD4cJB+Pj4n/TkzHqDLMVPpCcFBuY6jJT
	sSFtlowKrd8qOEfw0ZnzTyWhLwMDfc6x6TtP24L3gBlNfpSlFVtT4eZa+YbqaujF4CnqfFVEKKF
	4gSKv+DTFVTxx0H9lqfoqaZYRTKDhqc4GGRU0qukXB40QYgccyhHYVHfUjUW1TYkAbm8DKRNUEE
	7aYr/wlX+Gi9zT+3Z0YRMTe3WkJaERVpYNQc5adleGiOztUSwx3SHwi8KOxg6CZS7BMY=
X-Received: by 2002:a5d:6f05:0:b0:48b:6bb:6d3e with SMTP id
 ffacd0b85a97d-48b1274aa1bmr1223162f8f.15.1790886223483; Thu, 01 Oct 2026
 13:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179061193535.414394.10077526689774524435.stgit@ahduyck-xeon-server.home.arpa>
 <179080634117.434549.9870514324548682506@kernel.org>
In-Reply-To: <179080634117.434549.9870514324548682506@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Oct 2026 13:23:07 -0700
X-Gm-Features: AclHuK9KIESCl4RMwMgCLUPCJwZ9wt-ISIQXxSx-awibxCF0sqhGBBtZyx-uFgo
Message-ID: <CAKgT0UdGh_nLL52PWaDfC=eYC6zyDjVykwaW3uhUetaiVMUy7A@mail.gmail.com>
Subject: Re: [next-next PATCH v2 2/2] fbnic: Remove BMC routing rules when the
 BMC channel is disabled
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:12=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 (2) =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The commit message says "The instance lock is the one lock every
>   writer of the shadow holds", and fbnic_bmc_rpc_check() now takes=E2=80=
=A6
> - [Medium] fbnic_bmc_rpc_check() picks the new teardown only when
>   fbnic_bmc_rules_present() finds a MACDA entry carrying=E2=80=A6
> - [Medium] The new teardown runs only from fbnic_bmc_rpc_check(), which
>   only the service task calls.
> - [Low] The patch fixes user-visible bugs but has no Fixes: tag, and it
>   combines several fixes that could be split out and that come from=E2=80=
=A6
>
> Pre-existing issues:
> - [Medium] fbnic_bmc_rpc_check() now calls fbnic_rss_reinit() and then
>   __fbnic_set_rx_mode(), which runs=E2=80=A6
> - [Medium] fbnic_bmc_rpc_init() (fbnic_rpc.c:175-236) writes BMC unicast
>   MACs into slots starting at FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX, and=E2=
=80=A6
>
> --
>
> fbnic: Remove BMC routing rules when the BMC channel is disabled
>
> When the firmware reports that the BMC is gone but BMC-tagged rules are
> still programmed, fbnic_bmc_rpc_check() now removes the BMC MACDA
> entries, the BMC action rule and the host-unicast RSS entries. The patch
> also recomputes the RSS actions on every TCAM reinit and deletes action
> rules in any live state. It also takes the netdev instance lock across
> fbnic_bmc_rpc_check().
>
> > Take the instance lock over the whole of fbnic_bmc_rpc_check() while he=
re.
>
> [Severity: Low]
>
> This isn't a bug, but the patch has no Fixes: tag. It also combines
> several fixes that come from different commits:
>
> - the new BMC teardown when NC-SI is disabled while the host is up
>
> - the fbnic_bmc_rpc_all_multi_config() change from "=3D=3D VALID" to
>   "!=3D DISABLED". This fixes a separate pre-existing leak: ifdown demote=
s
>   the all-multi rule to UPDATE, and fbnic_write_rules() writes it back
>   at the next ifup.
>
> - the locking fix in fbnic_bmc_rpc_check(). The commit message traces
>   this to commit 60dd9781e9b8 ("fbnic: convert to
>   ndo_set_rx_mode_async"). It can be hit on every
>   FBNIC_FW_CAP_F_BMC_MACDA_SYNC pass, even if the BMC never disables.
>   git blame points at commit 04a230b27d8f3 for the service task reinit
>   path.
>
> Could these be split out, each with its own Fixes: tag? Stable could then
> take the locking fix without also taking the new teardown logic.

These are all low risk issues and this change is mostly just to clean
up a warning that was being triggered when the interface was stopped.
In addition due to the ordering of things backporting these would be a
pain since the code that introduces the original issue has been
changed several times so it is likely easier to just go forward with
this as a refactor rather than fixes to be backported.

> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_rpc.c
> > index 51fd0564d33f..939d56585b26 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
>
> [ ... ]
>
> > @@ -234,10 +236,91 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
>
> [ ... ]
>
> > +/**
> > + * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
> > + * @fbd: Pointer to fbnic device struct
> > + *
> > + * Undo fbnic_bmc_rpc_init() when the BMC drops its NC-SI channel whil=
e the
> > + * host interface stays up. Only marks shadow state; the caller's
> > + * __fbnic_set_rx_mode() pushes it to hardware, so ordering here is mo=
ot.
> > + */
>
> [Severity: Medium]
>
> What happens if the BMC disables its NC-SI channel while the host
> interface is down?
>
> Only the service task calls fbnic_bmc_rpc_check(), and the service task
> re-arms itself only while the netdev is running:
>
> drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_service_task() {
>     ...
>         if (netif_running(netdev))
>                 schedule_delayed_work(&fbd->service_task, HZ);
> }
>

If the interface is down the FW owns the RPC TCAMS and MAC/PCS/PHY so
it is responsible for doing the reconfiguration and setting up the
link. The ifup should be clearing out any bad state in the fw
capabilities structure and when it writes the rules it should be using
those to populate things.

> The last ifdown ran with the BMC present, so it left three things behind:
>
> - fbnic_clear_rules() left rule 63 as a DEST_BMC catch-all
> - fbnic_clear_macda() left the BMC-tagged MACDA entries valid
> - fbnic_rss_disable_hw() left RMI_CONFIG enabled
>
> On the next ifup, __fbnic_open() calls fbnic_bmc_rpc_init(), which
> returns early. It then calls fbnic_rss_reinit(), which only touches the
> mc/bc entries.
>
> After that, fbnic_up()->__fbnic_set_rx_mode() writes the stale state to
> hardware:
>
> - fbnic_write_rules() writes act rule 0 back, since ifdown demoted it to
>   UPDATE
> - fbnic_write_tce_tcam() programs TCE loopback again for the BMC MACs
>   that are still tagged
> - the leftover host-unicast RSS entries are written as well
>
> This only converges at the first service pass, at least HZ after ifup.
>
> If the interface goes down again inside that window, won't
> fbnic_clear_macda() still print "Found BMC MAC address w/ BMC not
> present"? The commit message says that warning is what this patch
> removes.

The FW is responsible for clearing the MACDA in that situation. Not the dri=
ver.

> [ ... ]
>
> >  void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
> >  {
> > +     struct fbnic_net *fbn =3D netdev_priv(fbd->netdev);
> >       int err;
> >
> > +     /* Nothing to do unless the firmware raised one of the flags. Tes=
t
> > +      * before taking the lock to keep it off the common path; one rai=
sed
> > +      * after this is picked up on the next pass.
> > +      */
> > +     if (!(READ_ONCE(fbd->fw_cap.state) & FBNIC_FW_CAP_BMC_PENDING))
> > +             return;
> > +
> > +     /* The rx mode work and the ethtool paths rewrite the MACDA and a=
ction
> > +      * TCAM shadows under the instance lock, and this runs from the s=
ervice
> > +      * task under RTNL only, so the two do not exclude each other.
> > +      */
> > +     netdev_lock(fbd->netdev);
>
> [Severity: High]
>
> The commit message says "The instance lock is the one lock every writer
> of the shadow holds." Is that true across the whole service task?
>
> fbnic_service_task() in fbnic_pci.c holds only rtnl_lock(). It calls
> fbnic_health_check() just before fbnic_bmc_rpc_check(). After a heartbeat
> loss, fbnic_health_check() calls fbnic_fw_config_after_crash(). That
> function rewrites the same shadow and the hardware without taking the
> instance lock:
>
> drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_fw_config_after_crash()=
 {
>     ...
>         fbnic_rpc_reset_valid_entries(fbd);
>         netif_addr_lock_bh(fbd->netdev);
>         __fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
>         netif_addr_unlock_bh(fbd->netdev);
>     ...
> }
>
> fbnic is ops-locked, so netdev_work_proc() runs netif_rx_mode_run()
> under the instance lock alone. netif_rx_mode_run() drops addr_list_lock
> before calling fbnic_set_rx_mode()->__fbnic_set_rx_mode() on the uc/mc
> snapshots.
>
> Can these two paths run at the same time on different CPUs? If so:
>
> - both could allocate MACDA slots through
>   __fbnic_uc_sync()/__fbnic_mc_sync()
> - fbnic_write_macda() could memset() an entry that the other side is
>   still filling in
> - one side could clear hardware entries the other side has just written
>
> There may also be a sync_cnt problem. The crash path syncs the live
> lists with __hw_addr_sync_dev(). __hw_addr_list_reconcile() then adds
> the snapshot delta on top:
>
> net/core/dev_addr_lists.c:__hw_addr_list_reconcile() {
>     ...
>                 real_ha->sync_cnt +=3D delta;
>                 real_ha->refcount +=3D delta;
>     ...
> }
>
> Would that leave sync_cnt/refcount inflated, so that a removed address
> is never unsynced from hardware?
>
> Should fbnic_fw_config_after_crash() also run under netdev_lock()? The
> other option is to take the lock around every part of the service task
> that writes the shadow.

Yeah, it probably should. That will likely require a follow-on patch.

> > +
> >       /* Consume the flag before the state it advertises. The ordering
> >        * implied by test_and_clear_bit() pairs with the barrier in
> >        * fbnic_fw_parse_bmc_cap(), and claiming it atomically means a s=
et
> > @@ -245,7 +328,15 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
> >        */
> >       if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
> >                              &fbd->fw_cap.state)) {
> > -             fbnic_bmc_rpc_init(fbd);
> > +             if (!fbnic_bmc_present(fbd) && fbnic_bmc_rules_present(fb=
d))
>
> [Severity: Medium]
>
> Does fbnic_bmc_rules_present() reliably tell us whether the host-unicast
> RSS entries are programmed?
>
> fbnic_rss_reinit() programs the host-unicast entries based only on
> fbnic_bmc_present(). It is also called from fbnic_set_rss_hash_opts()
> and fbnic_hwtstamp_set(), and neither of those sets a MACDA BMC tag.
>
> Take this sequence:
>
> 1. The BMC goes from absent to present. FW sets PRESENT and
>    TCAM_REINIT.
> 2. Before the next service pass, ethtool rx-flow-hash or SIOCSHWTSTAMP
>    calls fbnic_rss_reinit(). It sees the BMC present and programs the
>    host-unicast entries.
> 3. The BMC goes absent again.
> 4. The service pass sees !present && !rules_present and takes the else
>    branch. fbnic_bmc_rpc_init() returns early, and fbnic_rss_reinit()
>    skips the unicast entries:
>
>         for (i =3D fbnic_bmc_present(fbd) ? 0 : FBNIC_RSS_EN_NUM_UNICAST;
>              i < FBNIC_RSS_EN_NUM_ENTRIES; i++) {
>
> The host-unicast entries are then never deleted.
>
> The same result looks possible within a single pass.
> fbnic_fw_parse_bmc_cap() sets PRESENT from mailbox context without the
> instance lock. It can land after fbnic_bmc_rpc_disable() has marked the
> entries DELETE and before fbnic_rss_reinit() runs. fbnic_rss_reinit()
> then turns them back into UPDATE, with no BMC tags left.
>
> These entries match ahead of the mc/bc RSS entries. Unicast traffic would
> keep the old rss_en_mask, RXH_DISCARD and TS_ENA settings.
> fbnic_clear_valid_act_tcam() also demotes them to UPDATE, so they get
> written again at every ifup.
>
> Doesn't this leave the "stale and valid in hardware" case from the
> commit message still reachable?
>
> > +                     fbnic_bmc_rpc_disable(fbd);
> > +             else
> > +                     fbnic_bmc_rpc_init(fbd);
>
> [Severity: Medium]
>
> This is a pre-existing issue, but what happens here if the BMC MAC set
> changes between two TCAM_REINIT passes while fbnic_bmc_present() stays
> true?
>
> fbnic_bmc_rpc_init() writes the new BMC unicast MACs starting at
> FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX and adds the multicast ones via
> __fbnic_mc_sync(). It never clears FBNIC_MAC_ADDR_T_BMC from entries
> left over from the previous set:
>
>                 if (is_multicast_ether_addr(bmc_mac))
>                         mac_addr =3D __fbnic_mc_sync(fbd, bmc_mac);
>                 else
>                         mac_addr =3D &fbd->mac_addr[i++];
>
> The same happens if a disable and a re-enable with different MACs both
> arrive before one service pass. The new disable branch is skipped in
> that case.
>
> Would the MACs the BMC no longer reports stay BMC-tagged and valid? Act
> rule 0 would keep steering their Rx traffic to the BMC, and
> fbnic_write_tce_tcam() would keep looping host Tx for them to the BMC.

I will have to follow up on this as it is not a scenario we have seen.
For now I would likely address in a follow-on patch.

> > +
> > +             /* Neither path touches the RSS actions, which carry the =
mc/bc
> > +              * copy to the BMC, so recompute them alongside.
> > +              */
> > +             fbnic_rss_reinit(fbd, fbn);
> >               netif_addr_lock_bh(fbd->netdev);
> >               __fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->=
mc);
> >               netif_addr_unlock_bh(fbd->netdev);
>
> [Severity: Medium]
>
> This isn't a bug introduced by this patch, but can this pass run after
> the interface has been brought down?
>
> fbnic_service_task_stop() uses the non-sync cancel:
>
>         cancel_delayed_work(&fbd->service_task);
>
> A service task that has already started and is waiting in rtnl_lock()
> while fbnic_stop() runs will carry on afterwards. The other
> fbnic_rss_reinit() callers check netif_running(), but this path does
> not:
>
> drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c:fbnic_set_rss_hash_opts()=
 {
>     ...
>         if (netif_running(fbn->netdev)) {
>                 fbnic_rss_reinit(fbn->fbd, fbn);
>                 fbnic_write_rules(fbn->fbd);
>         }
>     ...
> }
>
> By that point fbnic_down_noidle() has demoted the host entries to UPDATE,
> and fbnic_disable() has shut down the host queues. If TCAM_REINIT is
> pending, __fbnic_set_rx_mode() writes the host RSS actions and MACDA
> entries back to hardware. Host traffic is then steered to disabled Rx
> queues until the next open/close.
>
> The hole existed before this patch, because __fbnic_set_rx_mode() on
> this path already rewrote the demoted entries. The added
> fbnic_rss_reinit() now also writes the host-unicast entries when the BMC
> has just become present.
>
> Should fbnic_bmc_rpc_check() return early when the netdev is not
> running?

Since this was a pre-existing issue we can probably look at addressing
it in a follow-on patch. Generally we shouldn't be touching the RPC
rules if we have stopped the interfaces. I will follow up on that and
verify as the __fbnic_set_rx_mode calls when the interface is not in
the running state could be problematic as it would route traffic to
the host which would just drop it at disabled queues. While it isn't
good behavior it would lead to some stats noise for us dropping
packets in the disabled HW queues.
