Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1B25B0B7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885026; cv=pass; b=Fzl2T4fYsU5slzs0UH0O61I1/c1V6qjFgkQWySfYjkUGFzvuFAvDOtxwz/TIXujuUhU5HdAkOgZpCHq0dDRXXBYYBn0nWsZXVSfFTeidjSF5MP8yGx33p90t2Vv7SLnW4/ocNPO1ZSks5f2MAicydNuJZkHHOMVi/lOx6VATCFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885026; c=relaxed/simple;
	bh=WcNPp2pw9LHrY+8xGL9bX3qNvfW5cvDb/7SrJDRhtAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBzdJ26AC4qvS7/IUuAm5z/ShxYmA3da+3JAafFmA41mtK68kLfT0zrqzwWt8WmloEFXW7X9WwTSqNa/RO45oljQnebiXG0vlRgawAuvVOA8xBI2lZAP/lljn7gk1GbtfXVAFSuJFslVCQjodYnJvQlzZrvc0ucdqrwpzRkXo78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3NIHST/; arc=pass smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3NIHST/"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01d89b23so1364005f8f.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790885022; cv=none;
        d=google.com; s=arc-20260327;
        b=gaWQB6VdlBiGXHbhbhGzLjvVZcx5s96sJpwLTLnVHCGGP8ziGSSJBDNGT/mIPoVw4L
         e47m9QKZo38y+qfWeYyqTAoSAjEWQBLYTtnofcCoxASEawRJm8/tBvb0pbJ6K3mLBtso
         Bn0kKJeAIAXfMeu/6g9D4JhJplZN7R48YyrWGVJFhiSUHqX/EbobjEMKpl6e5Vy1+iD5
         9mWh/fgODLpheKcdSWSmDeevQeKbBDHgZfWauS2bz9A7RXn/VpQwCm/84vkl1nMsk1/K
         Ayr41ksnJI1U9qcPPAkzA4gkUSYiosMsjOBJ2Zt9ehsi8Q7Q5dEVpPmaFB560p2UWAL7
         +IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pR2isw/xQVNsbeTwS5WTtVPWiAHj6qSG2y/TtZIDbNs=;
        fh=sgMlnpPIkoatpKB1xJDHQICPZqesERPploa6LoXqXLk=;
        b=lEdmFCzb8zSGwPYI2UQ4P0DXaCnT8DQ4VXeVxj2xza7tuJFJHT+uT1tCGqkEsm3puL
         pfJj0pbgPRyusFmCt0M2EKhgUohhxa34bc1lqCvA3cK8Z6K0xxmFQ80TXG2elytqZf0v
         JtXGl4GZBhlZ7cNoCitksfRrU8RegIa5u0WwCF26f2k01sRreAL8pK2RVNhfefZYpDPd
         hrvIQf6VIA3aaUIHm5vadiD0HKC2N4Oa/aYlifDUJsVf6FiGamnxaPqFUGlZu6n/xl1V
         wdqZivkMCdByO9iVapGBJxAI0IcSneLZIttzKC7DrAVlXpJOISVKYSQYC73te6I9IzX3
         vDtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790885022; x=1791489822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pR2isw/xQVNsbeTwS5WTtVPWiAHj6qSG2y/TtZIDbNs=;
        b=L3NIHST/haAZr34POau4aVG2pkDlQQlrkCx0QaKRtW9U6DnNMQn05u6gFkELyjKzO1
         GRy4gWVIkPq07X6Vuag+eiFosvG0/oWRJLm8Qtu+IYOS16tJGB06sORW+ZT+TFd8EEUr
         L7a3GoUMjmv8Y9DXsA4fPojrnB0VjmNSjcuwwgPdDQlBKyaooV4uClKZuXWj1k2bQKXg
         J5ZLtmX7bilz2tnxQZj5E7m60VJtGDU/vCiw5FxPQyBKt7Wjvmw1yg5M+o7liqsk9fRR
         nMVyWw10sRMCRSvJp2htwXvobEhGyGFdWfvBSmbX4ktBWbOTaYNG15632E0ArdbsHwnJ
         wf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885022; x=1791489822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pR2isw/xQVNsbeTwS5WTtVPWiAHj6qSG2y/TtZIDbNs=;
        b=bpkHPQqdxRnJk/mXi3jtv7O/THItetZIv8aBW+1QU0vOsjDgc72rWkx9JZmcMH8NGf
         WIoFXJdfEeU6Hv/GH37wZ1HwBPHp0CJzZFd0UP4zJjlSztNIrvaC1GKlBIfj0zzczL9p
         aiGTcbkzVPuqqb96G7Ocws4oQGON73y5yoRy26Cnp/PKPUbUfSjlSBNFu9i1zyo0pOtd
         NtP7ztuBSnNnsZYL1ocdHUj2a09ZeDWcSpTC8DnExIqPt5OjtyuUW4DlaALcYttpgqq0
         fu8azpd6yARZWrlfxCEVTHjHjfaCyAVp5rdSIoUjGVyTDDFaa1heO98mg1wybltfVzOk
         cmoQ==
X-Gm-Message-State: AFq9FYLVpBF+6V3i2xLvcRDPk2dvGG2sEa/acfDo1yh4ux7k9uaGXnlD
	GGNslz/73H3CmGPgLrKE7ro0ZZ/DmiaZL4yV0PM6ioL3f2QnyqzdDiRYyraBiDxDUN2JjIzrUyG
	ZJmm9vAMPtwOc7w7hYbXRJjoOrVKrPpE=
X-Gm-Gg: AYBFou2W1KSlNkXin3Tg0dS5gwnO+uGm0725mmX1T/kBFYiVKSrAGSTPauo6+VQAosJ
	Qdwfq3RvIEcp7/nXRXjFju0MCaOBMdVs2ImxPAiN4vMKhiP2h+/zjm7sRdPBHVM7FUCq2zCxVDG
	TCjOCFQGjPOrnLe6Lhs3hIn7URDlmDRhny1AUcoG6urF2qOItZ7gmIMBIM3LlGG7eNY5d/rgYMk
	LLf99+mfEhtwMArg+ESg7XDx2e1D8H05lAlU5iPPGSbvnXP5wwyqTJKbfu/BYYjZv1k6KmsgpLz
	pAGDa8zzajeiazRaJFv2cFMbFjuxieN2BT6bVpe+94rdw9F3f+kBqBStHd1CoRjrjet/jJB5XPj
	CUXgkgddvDu4feTvZOzhlgiX36JSvGK3eype/5tnc28KN5XyTp9cq/G7v
X-Received: by 2002:adf:e009:0:10b0:487:172:6293 with SMTP id
 ffacd0b85a97d-48b126bd980mr984302f8f.3.1790885022082; Thu, 01 Oct 2026
 13:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179061192791.414394.2161969547553719796.stgit@ahduyck-xeon-server.home.arpa>
 <179080633998.434549.16996546396415552279@kernel.org>
In-Reply-To: <179080633998.434549.16996546396415552279@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Oct 2026 13:03:05 -0700
X-Gm-Features: AclHuK8dwk6hlea77aU4_oxsK5x8MobrUEAyJ8JILa0a0sDh4YTyI-7qNGKH3YI
Message-ID: <CAKgT0UdRO3V5NgotZsVcstdigBDLPqmCT31OMdx7JZrRqUGXwA@mail.gmail.com>
Subject: Re: [next-next PATCH v2 1/2] fbnic: Rework the BMC state pulled from
 the capabilities message
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
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (7) =C2=B7 Low: 2 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In this patch, a present-with-MAC to present-without-MAC
>   capabilities message clears FBNIC_FW_CAP_F_BMC_PRESENT and raises=E2=80=
=A6
> - [Medium] fbnic_fw_parse_bmc_cap() now clears FBNIC_FW_CAP_F_BMC_PRESENT
>   whenever firmware reports BMC_PRESENT without a MAC array.
> - [Low] The commit is titled as a rework, but it fixes at least two real
>   bugs and has no Fixes: tags.
> - [Low] The commit message says that with the old -EINVAL, "the link
>   speed, FEC and anti-rollback version in the same message are no longer=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] When a BMC becomes present while the interface is up, the RSS
>   mc/bc action entries are not rebuilt with DEST_BMC, because=E2=80=A6
> - [Medium] The disable branch in fbnic_bmc_rpc_all_multi_config() moves
>   act_tcam[FBNIC_RPC_ACT_TBL_BMC_ALL_MULTI_OFFSET] to DELETE only when=E2=
=80=A6
> - [Medium] fbnic_bmc_rpc_all_multi_config() treats
>   mac_addr[mac_addr_boundary - 1] being VALID as proof that it already=E2=
=80=A6
> - [Medium] In fbnic_sift_macda(), the inner while loop does not break
>   after it moves a qualifying BMC-only entry into dest_addr.
> - [Medium] fbnic_bmc_rpc_check() consumes FBNIC_FW_CAP_F_BMC_MACDA_SYNC
>   before it calls fbnic_fw_xmit_rpc_macda_sync(), and does not raise the=
=E2=80=A6
> - [Medium] fbnic_bmc_rpc_check() runs from the service task under RTNL
>   only.
> - [Medium] FBNIC_FW_CAP_RESP_BMC_MAC_ADDR is validated as
>   FBNIC_TLV_BINARY, which accepts any payload length from 1 to ETH_ALEN=
=E2=80=A6
> - [Low] The mailbox parser can overwrite fbd->fw_cap.bmc_mac_addr for
>   response B while the service task is still validating and copying it=E2=
=80=A6
>
> --
>
> fbnic: Rework the BMC state pulled from the capabilities message
>
> This moves the BMC parsing out of fbnic_fw_parse_cap_resp() into a new
> fbnic_fw_parse_bmc_cap() helper. A BMC reported present without a MAC
> array is now treated as absent instead of rejecting the whole message.
>
> The BMC bitfield members are replaced by atomic bitops on a new
> fw_cap.state word. The reinit handoff is ordered with
> smp_mb__before_atomic() and test_and_clear_bit(), and all_multi is now
> always taken from the message.
>
> > The firmware reports the BMC present as soon as its NC-SI channel is
> > enabled, before the BMC has been assigned a MAC address. Such a message
> > carries no BMC MAC array and is rejected with -EINVAL, discarding the r=
est
> > of it. Treat a present BMC with no MAC as absent instead. There is no e=
ntry
> > to steer traffic to without one, so the BMC paths stay disabled either =
way,
> > and the link speed, FEC and anti-rollback version in the same message a=
re
> > no longer thrown out with it.
>
> [Severity: Low]
> Is the part about link speed and FEC accurate? The baseline
> fbnic_fw_parse_cap_resp() stores both of them before it reaches the BMC
> block that returned -EINVAL:
>
>         fbd->fw_cap.link_speed =3D
>                 fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_SPEED);
>         fbd->fw_cap.link_fec =3D
>                 fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_FEC);
>
>         bmc_present =3D !!results[FBNIC_FW_CAP_RESP_BMC_PRESENT];
>         if (bmc_present) {
>                 ...
>                 if (!attr)
>                         return -EINVAL;
>
> The only caller, fbnic_mbx_process_rx_msgs(), logs "Unable to process
> message" and does not undo fields that were already written.
>
> The old code actually lost anti_rollback_version and the
> need_bmc_tcam_reinit raise. It also left bmc_present, bmc_mac_addr and
> all_multi at their previous values.
>
> Could the commit message describe that impact instead?

This reads like a bit of a word soup to me. I assume this is asking
for an update to the commit message or is this asking for additional
changes so that we force all the error returns to be processed before
we start storing the values.

To me it sounds like we may need to do some additional follow-up work.

> > bmc_present, need_bmc_tcam_reinit, need_bmc_macda_sync and all_multi ar=
e
> > single bit members of one bitfield, so every write to one is a
> > read-modify-write of all four. The mailbox writes three of them and the
> > service task writes the other two.
>
> [ ... ]
>
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>
> [Severity: Low]
> The subject calls this a rework, but it seems to fix at least two real
> bugs. Should it have Fixes: tags?
>
> The -EINVAL rejection of a BMC_PRESENT message without a BMC_MAC_ARRAY
> comes from:
>
> Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of o=
ur presence")
>
> The shared u8 bitfield comes from:
>
> Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enab=
les channel")
> Fixes: cee8d21d8091 ("fbnic: Push local unicast MAC addresses to FW to po=
pulate TCAMs")
>
> Three contexts write that bitfield: the mailbox threaded IRQ, the service
> task, and the rx-mode path through fbnic_write_macda(). Each write is a
> non-atomic read-modify-write of the whole byte, so updates can be lost.
>
> These fixes are also mixed in with the helper extraction and the
> all_multi semantics change. Would splitting them out make a stable
> backport easier?

I considered it, however none of these rise to the level of being
something that really needs a backport. The FW sends these messages
quite seldomly and they are almost always at the start of init. The
code itself is mostly there for exception handling for a BMC that
decides to jump channels which is a very rare event so this likely
doesn't jump to the point of needing a "fixes" tag.

> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_fw.c
> > index 47894b45676b..49b8813a3564 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > @@ -620,11 +620,55 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_ad=
dr[][ETH_ALEN],
> >       return 0;
> >  }
> >
> > +static int fbnic_fw_parse_bmc_cap(struct fbnic_dev *fbd,
> > +                               struct fbnic_tlv_msg **results)
> > +{
> > +     struct fbnic_tlv_msg *attr;
> > +     bool bmc_present =3D false;
> > +     u32 all_multi =3D 0;
> > +     int err;
> > +
> > +     /* FW reports the BMC present once its NC-SI channel is enabled, =
before
> > +      * it has a MAC. No MAC array means nothing to program, so treat =
it as
> > +      * absent rather than rejecting the message.
> > +      */
> > +     attr =3D results[FBNIC_FW_CAP_RESP_BMC_PRESENT] ?
> > +            results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY] : NULL;
>
> [Severity: Medium]
> Does treating present-without-MAC as absent affect more than MAC
> steering? fbnic_bmc_present() also decides what happens to the link and
> the RX parser on ifdown:
>
> fbnic_stop()
>         phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
>
> fbnic_rss_disable_hw()
>         if (!fbnic_bmc_present(fbd))
>                 wr32(fbd, FBNIC_RPC_RMI_CONFIG,
>                      FIELD_PREP(FBNIC_RPC_RMI_CONFIG_OH_BYTES, 20));
>
> fbnic_clear_rules() also uses it to decide whether to keep the last
> BMC-routing action rule.
>
> Before this patch, a present-without-MAC message that followed a
> present-with-MAC message was rejected. That could happen during firmware
> recovery, or when the BMC clears its MAC filters but keeps the channel
> enabled. bmc_present stayed set, so link and RPC stayed up on ifdown.
>
> If the host now does an ifdown in that window, can the link and the RX
> parser be shut off while the NC-SI channel is still active? The service
> task is not rescheduled while the interface is down. A later message that
> restores the MAC would not bring the link back until the host brings the
> interface up again.
>
> The commit message only says "the BMC paths stay disabled either way" and
> does not mention these link and RPC effects. Can firmware send
> present-without-MAC after present-with-MAC with no absent message in
> between?
>
> > +     if (attr) {
> > +             err =3D fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr=
,
> > +                                            attr, 4);
>

If the link is brought down by the host driver, then the driver sends
a message to the FW letting it know it is releasing ownership. Even if
the host driver crashes the heartbeat will timeout and the FW will
seize ownership. One side effect of that is the FW then becomes
responsible for managing the RPC and link so this becomes moot.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but can a short MAC attribute
> cause an out-of-bounds read here? FBNIC_FW_CAP_RESP_BMC_MAC_ADDR is
> validated as FBNIC_TLV_BINARY, which accepts any length from 1 to
> ETH_ALEN:
>
> fbnic_tlv_attr_validate()
>         case FBNIC_TLV_BINARY:
>                 if (!len || len > tlv_index->len)
>                         return -EINVAL;
>
> However, fbnic_tlv_attr_addr_copy() always copies ETH_ALEN bytes:
>
>         mac_addr =3D fbnic_tlv_attr_get_value_ptr(src);
>         memcpy(dest, mac_addr, ETH_ALEN);
>
> If a truncated MAC attribute sits at the end of a firmware message, the
> copy reads past the attribute, and possibly past the receive page, into
> bmc_mac_addr[]. Those bytes are then programmed into the TCAM.
>

I suppose it might be possible. We can probably look at adding an
additional verification to enforce the length in a follow-on patch.

> [Severity: Low]
> This is a pre-existing issue, but what stops this write to
> fbd->fw_cap.bmc_mac_addr from racing with the reader in
> fbnic_bmc_rpc_init()?
>
> fbnic_bmc_rpc_init()
>         for (j =3D 0; j < 4; j++) {
>                 u8 *bmc_mac =3D fbd->fw_cap.bmc_mac_addr[j];
>                 ...
>                 ether_addr_copy(mac_addr->value.addr8, bmc_mac);
>
> The mailbox can parse response B while the service task is still copying
> the addresses from response A. One pass could then program a MAC made of
> bytes from both responses.
>
> The new ordering does place B's set_bit() after B's writes, so another
> reinit pass follows. The snapshot taken in that first pass is still not
> coherent.

In general these events should not be firing that quickly. The BMC
changing a channel and triggering this sort of event should be a rare
event so we shouldn't have two updates coming in at the same time. In
addition normally we would go from channel disabled, to channel
enabled and then MAC being set. As such we would go from !bmc_present
to bmc_present only after the MAC address has been assigned.

> > +             if (err)
> > +                     return err;
> > +
> > +             all_multi =3D fta_get_uint(results,
> > +                                      FBNIC_FW_CAP_RESP_BMC_ALL_MULTI)=
;
> > +             bmc_present =3D true;
> > +     } else {
> > +             memset(fbd->fw_cap.bmc_mac_addr, 0,
> > +                    sizeof(fbd->fw_cap.bmc_mac_addr));
> > +     }
> > +
> > +     /* all_multi is only read out of the message when a BMC is presen=
t, so
> > +      * it is never set on its own and callers can test it without pai=
ring
> > +      * it with the presence check.
> > +      */
> > +     assign_bit(FBNIC_FW_CAP_F_BMC_PRESENT, &fbd->fw_cap.state, bmc_pr=
esent);
>
> [Severity: Medium]
> What happens to the BMC rules already in hardware when a
> present-with-MAC message is followed by a present-without-MAC one? This
> clears FBNIC_FW_CAP_F_BMC_PRESENT and raises TCAM_REINIT, but
> fbnic_bmc_rpc_init() then returns early:
>
> fbnic_bmc_rpc_check()
>     fbnic_bmc_rpc_init()
>         if (!fbnic_bmc_present(fbd))
>                 return;
>
> Nothing removes the BMC-tagged MACDA entries, action rule 0, or the
> DEST_BMC bit on the RSS multicast and broadcast entries. Does hardware
> keep steering traffic to a BMC that the driver now considers absent,
> until the interface is bounced?
>
> The next patch in the series, "fbnic: Remove BMC routing rules when the
> BMC channel is disabled", adds fbnic_bmc_rpc_disable() and calls
> fbnic_rss_reinit() from fbnic_bmc_rpc_check(). That resolves this by the
> end of the series.

Yes, that is the point of the second patch. The first one didn't
remove the MAC rules it was only handling adding them. We needed to
add the logic to clear them because the rules were being left behind
and triggered a warning when the interfaces was stopped for BMC rules
being there but no BMC present.

> > +     assign_bit(FBNIC_FW_CAP_F_BMC_ALL_MULTI, &fbd->fw_cap.state, all_=
multi);
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_rpc.c
> > index ab6e342ec3fa..51fd0564d33f 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> > @@ -117,7 +117,7 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_de=
v *fbd,
> >        * BMC.
> >        */
> >       mac_addr =3D &fbd->mac_addr[fbd->mac_addr_boundary - 1];
> > -     if (fbnic_bmc_present(fbd) && fbd->fw_cap.all_multi) {
> > +     if (fbnic_bmc_all_multi(fbd)) {
> >               if (mac_addr->state !=3D FBNIC_TCAM_S_VALID) {
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does a VALID state prove
> that mac_addr[mac_addr_boundary - 1] holds the multicast wildcard? The
> value, mask and owner are not checked. __fbnic_uc_sync() can also give
> that index to a host unicast address once the higher entries are full:
>
> __fbnic_uc_sync()
>         for (i =3D fbd->mac_addr_boundary - 1;
>              i < FBNIC_RPC_TCAM_MACDA_HOST_ADDR_IDX; i++) {
>
> In that case the wildcard is never installed, and the BMC all-multi
> action rule (DEST_BMC) matches the MACDA index of the host's unicast
> address. Wouldn't that address's traffic then go only to the BMC?
>
> This needs BMC all-multi on, host all-multi off, and enough extra host
> unicast addresses to fill the entries above the boundary.
>

The VALID flag means the rule was written to the HW and is in use.

I will have to recheck the logic on this. The "- 1" may be incorrect
as I believe this logic is supposed to start at the mac_addr_boundary,
not before. Likely material for yet another follow-on patch.

> >                       eth_zero_addr(mac_addr->value.addr8);
> >                       eth_broadcast_addr(mac_addr->mask.addr8);
> > @@ -144,7 +144,7 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_de=
v *fbd,
> >       /* If we are not enabling the rule just delete it. We will fall
> >        * back to the RSS rules that support the multicast addresses.
> >        */
> > -     if (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi || enable_h=
ost) {
> > +     if (!fbnic_bmc_all_multi(fbd) || enable_host) {
> >               if (act_tcam->state =3D=3D FBNIC_TCAM_S_VALID)
> >                       act_tcam->state =3D FBNIC_TCAM_S_DELETE;
>
> [Severity: Medium]
> This is a pre-existing issue, but does this check skip entries in the
> UPDATE state? After ifdown, fbnic_clear_valid_act_tcam() leaves
> act_tcam[FBNIC_RPC_ACT_TBL_BMC_ALL_MULTI_OFFSET] in UPDATE. It is then
> not moved to DELETE here, and fbnic_write_rules() writes it back as a
> BMC-only rule even when host all-multi is requested. The BMC-only rule
> would then take over host all-multicast delivery.
>
> The next patch in the series, "fbnic: Remove BMC routing rules when the
> BMC channel is disabled", changes this test to
> act_tcam->state !=3D FBNIC_TCAM_S_DISABLED.

This is pointing out something fixed in the next diff. Not sure why it
felt the need to call this out here.

>
> >               return;
> > @@ -238,20 +238,25 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
> >  {
> >       int err;
> >
> > -     if (fbd->fw_cap.need_bmc_tcam_reinit) {
> > +     /* Consume the flag before the state it advertises. The ordering
> > +      * implied by test_and_clear_bit() pairs with the barrier in
> > +      * fbnic_fw_parse_bmc_cap(), and claiming it atomically means a s=
et
> > +      * racing with us is kept and retried rather than overwritten.
> > +      */
> > +     if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
> > +                            &fbd->fw_cap.state)) {
> >               fbnic_bmc_rpc_init(fbd);
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but when a BMC becomes present
> while the interface is up, do the RSS multicast and broadcast action
> entries ever get rebuilt with DEST_BMC? That bit is only computed in
> fbnic_rss_reinit():
>
>         if (i >=3D FBNIC_RSS_EN_NUM_UNICAST && fbnic_bmc_present(fbd))
>                 dest |=3D FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
>                                    FBNIC_RPC_ACT_TBL0_DEST_BMC);
>
> This reinit path does not call fbnic_rss_reinit(), so the BMC would miss
> broadcast and shared multicast traffic until the interface is bounced.
>
> This has been the case since 04a230b27d8f ("fbnic: Add logic to
> repopulate RPC TCAM if BMC enables channel"). The next patch in the
> series, "fbnic: Remove BMC routing rules when the BMC channel is
> disabled", adds fbnic_rss_reinit(fbd, fbn) to this path.

Again, why is it calling this out if it already acknowledged it gets
fixed in the next patch?

> [Severity: Medium]
> This is also pre-existing, but what serializes this path against the
> async rx-mode worker? fbnic_bmc_rpc_check() runs from the service task
> holding only RTNL. It modifies fbd->mac_addr[] and fbd->act_tcam[] here,
> then walks the MACDA table in fbnic_fw_xmit_rpc_macda_sync().
>
> For ops-locked devices, the async rx-mode callback modifies the same
> arrays while holding only the netdev instance lock:
>
> netdev_work_proc()
>         netdev_lock_ops_compat(dev);
>         ...
>         netdev_work_run(dev, events, core);
>
> The two lock sets do not overlap. Can both sides update the TCAM shadow
> state at the same time and send firmware an inconsistent snapshot?
>
> The next patch in the series, "fbnic: Remove BMC routing rules when the
> BMC channel is disabled", adds netdev_lock()/netdev_unlock() around
> fbnic_bmc_rpc_check().
>
> >               netif_addr_lock_bh(fbd->netdev);
> >               __fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->=
mc);

Again, fixed in next patch.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but __fbnic_set_rx_mode()
> calls fbnic_sift_macda(), and the inner loop there keeps going after it
> moves an entry:
>
> fbnic_sift_macda()
>                 while (src < fbd->mac_addr_boundary) {
>                         struct fbnic_mac_addr *src_addr =3D &fbd->mac_add=
r[src++];
>                         ...
>                         memcpy(dest_addr, src_addr, sizeof(*src_addr));
>                         src_addr->state =3D FBNIC_TCAM_S_DELETE;
>                         dest_addr->state =3D FBNIC_TCAM_S_ADD;
>                 }
>
> With two or more BMC-only multicast addresses, won't the second matching
> source be copied over the same dest_addr, with both sources marked
> DELETE? The first BMC-only multicast filter would then be lost. Is a
> break missing after the move?

I will have to look into that. If it is an issue it is material for a
follow-on patch.

> >               netif_addr_unlock_bh(fbd->netdev);
> > -             fbd->fw_cap.need_bmc_tcam_reinit =3D false;
> >       }
> >
> > -     if (fbd->fw_cap.need_bmc_macda_sync) {
> > +     if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
> > +                            &fbd->fw_cap.state)) {
> >               err =3D fbnic_fw_xmit_rpc_macda_sync(fbd);
> >               if (err)
> >                       dev_warn(fbd->dev,
> >                                "Writing MACDA table to FW failed, err: =
%d\n", err);
>
> [Severity: Medium]
> This is a pre-existing issue, since the old code also cleared
> need_bmc_macda_sync unconditionally. Should the flag be set again when
> fbnic_fw_xmit_rpc_macda_sync() fails?
>
> A transient -ENOMEM or -ENOSPC, or -EBUSY from a full mailbox, leaves
> firmware with a stale MACDA list and stale receive-mode flags. That lasts
> until some other change sets FBNIC_FW_CAP_F_BMC_MACDA_SYNC again.
>

This would likely lead to us just hammering the mailbox resulting in a
stream of errors rather than the error presenting as a warning and
likely getting resolved after the issues with the mailbox get
resolved. Resolving the mailbox issues would likely require a resync
of things with the FW anyway as dropping messages would result in a
loss of state sync between the FW and the host.

> > -             fbd->fw_cap.need_bmc_macda_sync =3D false;
> >       }
> >  }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/179061185153.414394.13396934246780284806.stgit%40ahduyck-xeon-server.ho=
me.arpa
