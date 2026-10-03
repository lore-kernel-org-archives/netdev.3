Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006323F9A1E
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021354; cv=none; b=uA8fpX2m8l34Ol1UfDJCWgBDAuM/pvdZv1yW/7MIzx5MOP6TBMTLSZ7LQaFbDh4im5F9BC7r47XnPoHrW3U8HK+A/phYIX/yJ/hPWZYVYcG5XKI05d4heUB5blcQ69j/2pKWJoEVZwO8JuGV2BGu5sj0vIDvv0xXUj0TsG3zmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021354; c=relaxed/simple;
	bh=NNdvpSbWcpCDak+fCIfxwUO4njtUxnGMFI2EIxozuaw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gX8uoPQpkylEu0YwddnQK30xKGsVqyh0KGFxjTNB4YJ/VlxglbtZeMBq3NYM4UXrvNWsPHjSQkAHxD28jJdaTxN/nba0a8ALTtl7HlfuZRsulf8CVyAf8vimC7aX3vSJ0F0cy+OFLhjLdt1AegZL/vlTiilUawDG0xmNSeuoQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dH9xsElO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia0apF5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dH9xsElO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia0apF5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=211tvn9y3p5J+u/mzZRpmt2Ac+xaJHBNaH1jQgm5GKo=;
	b=dH9xsElO/z3yjgDkFzufYx9quXyQxhcBv544IfzjYMQyiz6l00s1jkSTpav17PCnpsaZYN
	HZko41GQ5XzBc6o1MxXRi/Tu7aijrQtHgGNzfC1yxwHif1v5kh54SU/Bc8IjOEmHOdge2u
	MWzIGUDVNMn2locybUeR8qUyP5pSlUo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-MmXGnIaDMUi1DLMd1_OMgw-1; Sat, 03 Oct 2026 05:55:50 -0400
X-MC-Unique: MmXGnIaDMUi1DLMd1_OMgw-1
X-Mimecast-MFC-AGG-ID: MmXGnIaDMUi1DLMd1_OMgw_1791021349
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a004b70f99so3814155e9.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021349; x=1791626149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=211tvn9y3p5J+u/mzZRpmt2Ac+xaJHBNaH1jQgm5GKo=;
        b=Ia0apF5Jav/Dcn3J0jRE9lPIxZeUSR3QVGmQNtfY940Gr5xJ4ZMi1jfZnmnPAOryKQ
         /3QNf0VyL6hCCOZrR6pmGjl5rhQLjjAjGmEh6Kf1h3E9SFbj9LQ/6it4XlIpdoSQLfjn
         Spf86Hjo357Nu6YxhvH2T5BcgLW6nid9I2yQia0gkCciyMmu8sakBge9Fh8m8Kb4/tP5
         7mURopLZVvGPz4L9c6dc/FQW602iEqTdJ5AbCWwkDQfK9iweEm3hR+SV2L/8WUSM2pQ2
         2JP2f5uczQEiF2v6mRpJvkuvJbUefK3WGx9R/zr3h7ZayKwKRCYGT+K1rZtpArrMX5DR
         duMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021349; x=1791626149;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=211tvn9y3p5J+u/mzZRpmt2Ac+xaJHBNaH1jQgm5GKo=;
        b=DmC/JBZWjA/qWK2MxA6EKR1FHNOCVSEC7sI2dEri0IXLhTG8CxIUD0y6slqIK38soP
         peUXmJoYB8/XW5MzNJv+rHIw+Jd6WZdwQaoSt0s4tgNwD9CY9iBUcvCy5/jW2UGXhvzp
         2GnY3Q777ZKgr1xeXo/2gAb+rcW39rDQ4INO4dbudhxgrnUODUQttLfM+Wo4+Qu60wpo
         /e/MQN0Zadi98OXOE5B3f+n49FWQch0XSBv3U67V69yLUNA8iojZk2LjW/gOD+/b11ib
         zq0IL1395Qib4mwZPUxyikyiW35tYyjlX6zQ5TE8VOb+2ZZ4fVf3DExC25S1PrkyGe57
         yZtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwpkPk2+Om6fDvTIOnqORsJVx4az6XxP5dfvKWqvjk0ZK6VyUEoQxeaCkixRBkbDx1iJkdqnI=@vger.kernel.org
X-Gm-Message-State: AFuF++krZ7A5BLylKBYaGpa/g2OBrHOrYSK0ewSxAkOdlzOdmof96JfK
	McjKAlIWwX2HhYQy/Tfn0qTx3WlIN7Low9/Q9aL5Ey0qErMlAacdzdk0Ko5BpGIjceM1Sqrqc9g
	Zt9UwyTjj/3YH7DNGTPwJcdM4nsnym/jyqqYPPmNLsyg8hhUc5lSw/2f7lA==
X-Gm-Gg: AYBFou1u1aLEahqNYfkz9F56001Qyu9WCp4eS+6T6GHcwNbUNVTV/qTtrEyl1Q5V1Jh
	gYgSl32+NPVJNly457e6Lfbfy/GWTTnpq1tYVSh9r9Jzyvvc7UepW1OlCBCxJPzHk5ASofdjN4+
	qjfywAJcJkGO1pi3Ax01kimt6Oe4yK19jLKLL2TAgM4nPkEoBusHV5zR6Ap9nECmI4vlhmlAP7+
	YNUlmXOd2UUKfzznrty1+jV2vNs3fQXw9gtb0NzpMKfJQgZUJkA7NG6rUFTV3Vaamz1fYdA34xb
	4RpxJ2r63JtkUeyHfgzFswdYD69ULghpufLVcPYr4bQtIU+BuhSEAUViVdzDr8flYo5tW+zCAwY
	qwKE6H4VDM1PzZAsb9amZBLT0KoajtY+2OVzZ9N4=
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id 5b1f17b1804b1-4a02758653cmr85580215e9.16.1791021349362;
        Sat, 03 Oct 2026 02:55:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id 5b1f17b1804b1-4a02758653cmr85580005e9.16.1791021348969;
        Sat, 03 Oct 2026 02:55:48 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16bcb9a21sm38091735e9.10.2026.10.03.02.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:55:48 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:47 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_07/10=5D_ice=3A_take_the_swit?=
 =?US-ASCII?Q?ch_rule_AQ_error_from_the_response_descriptor?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-8-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-8-poros@redhat.com>
Message-ID: <9B559EBB-75B5-43C6-AA5F-304E2AED20AE@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:49 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by
>reading hw->adminq=2Esq_last_status after ice_aq_send_cmd() returned=2E T=
hat
>field is shared by every admin queue user and is only stable while the
>send queue lock is held=2E Another AQ command completing in between can
>overwrite it, so a failed removal is reported as a generic error, and a
>successful one can even be turned into -ENOENT, because the check is
>not limited to the failure case=2E A caller that sees -ENOENT keeps its
>rule bookkeeping while the rule is gone from the hardware=2E
>
>ice_vsi_sync_fltr() has the same problem with ENOSPC=2E It checks
>sq_last_status only after it has freed the list of filters it tried to
>add=2E Every entry is a separate devres allocation, so freeing a list of
>thousands of entries takes seconds, and by then the value usually
>belongs to a different command, so the MAC filter overflow handling is
>never entered=2E With debug prints of the error and sq_last_status added
>to both places:
>
>  ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
>  ice 0000:04:00=2E0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0
>
>Use the retval of the descriptor that ice_aq_send_cmd() copies back,
>only when the command failed, translate ENOSPC on add to -ENOSPC and
>let ice_vsi_sync_fltr() check the return code instead of
>sq_last_status=2E
>
>i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix race
>condition while adding/deleting MAC/VLAN filters")=2E
>
>Fixes: ca1fdb885e5f ("ice: return correct error code from ice_aq_sw_rules=
")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_main=2Ec   |  4 +---
> drivers/net/ethernet/intel/ice/ice_switch=2Ec | 13 ++++++++++---
> 2 files changed, 11 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main=2Ec b/drivers/net/et=
hernet/intel/ice/ice_main=2Ec
>index 8a21f87eb6ca21=2E=2Eceb9fec2af21e7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_main=2Ec
>@@ -396,8 +396,6 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> 	struct device *dev =3D ice_pf_to_dev(vsi->back);
> 	struct net_device *netdev =3D vsi->netdev;
> 	bool promisc_forced_on =3D false;
>-	struct ice_pf *pf =3D vsi->back;
>-	struct ice_hw *hw =3D &pf->hw;
> 	u32 changed_flags =3D 0;
> 	int err;
>=20
>@@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> 		 * should go into promiscuous mode=2E There should be some
> 		 * space reserved for promiscuous filters=2E
> 		 */
>-		if (hw->adminq=2Esq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC &&
>+		if (err =3D=3D -ENOSPC &&
> 		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
> 				      vsi->state)) {
> 			promisc_forced_on =3D true;
>diff --git a/drivers/net/ethernet/intel/ice/ice_switch=2Ec b/drivers/net/=
ethernet/intel/ice/ice_switch=2Ec
>index 239d4d9633baa6=2E=2Eae96a2003d5c5e 100644
>--- a/drivers/net/ethernet/intel/ice/ice_switch=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_switch=2Ec
>@@ -1959,9 +1959,16 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list=
, u16 rule_list_sz,
> 	desc=2Eflags |=3D cpu_to_le16(LIBIE_AQ_FLAG_RD);
> 	cmd->num_rules_fltr_entry_index =3D cpu_to_le16(num_rules);
> 	status =3D ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz, cd);
>-	if (opc !=3D ice_aqc_opc_add_sw_rules &&
>-	    hw->adminq=2Esq_last_status =3D=3D LIBIE_AQ_RC_ENOENT)
>-		status =3D -ENOENT;
>+	if (status) {
>+		enum libie_aq_err aq_err =3D le16_to_cpu(desc=2Eretval) & 0xff;
>+
>+		if (opc !=3D ice_aqc_opc_add_sw_rules &&
>+		    aq_err =3D=3D LIBIE_AQ_RC_ENOENT)
>+			status =3D -ENOENT;
>+		else if (opc =3D=3D ice_aqc_opc_add_sw_rules &&
>+			 aq_err =3D=3D LIBIE_AQ_RC_ENOSPC)
>+			status =3D -ENOSPC;
>+	}
>=20
> 	if (!status) {
> 		if (opc =3D=3D ice_aqc_opc_add_sw_rules)

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

