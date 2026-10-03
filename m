Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9037E2EB
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021150; cv=none; b=aZqgyrUYB3KqHadF6echxS711PryywGxq+eLYDloXQRyTtzxIC5+QDprUIaXIMHteDCeAegjM+3SFEevnvfGCjGM2rnxOiIt1BaZMZWAx85t5alHhOO6v1QBbenS+y++bYm2Vy8od3Ll0onxm/zU0Whnse4z8A9YOKiR1WEcqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021150; c=relaxed/simple;
	bh=jweMfYQRoaoBEfkGOCvQZk+QPSNSvCLvtEJzzzW4538=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cK5MJ7FyW9CgiTqksbXPLZrgTjKMmu5OPP2DD8lnCYdycdadwVdGH/UYLr0l3QJsDbiVGWaSqqTrgHkKrk8nkKxQlhzjDJucCFXj5Wy9aW3LZzRu3OJlQzsKTplljyCIourr4aaE0sM6ck2VBBInzDdDe3HwFfbCtYGak1gFwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpmdls5k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKPEJjeg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpmdls5k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKPEJjeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGwiD5BsIU7SMUvm8z3LsVJJc+9NsNqtDssS4ilkK84=;
	b=cpmdls5kI46cIEXNBJt56HU8LEMwFkBSAPhlQy/2n6rY1g+RMEM49B8ur4gCVepwNZxw5K
	n7E/hUQWCRjd20cXFR0yb0EUjTR75RYmfLRX6stTyA3MUAtGgtro3CM4ODGFog9C/mmrjl
	mUjTnLFFoem6cUZcWgM1WzxYMy+9mZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-B8U6AH86OUO6uDK2Qj5exw-1; Sat, 03 Oct 2026 05:52:26 -0400
X-MC-Unique: B8U6AH86OUO6uDK2Qj5exw-1
X-Mimecast-MFC-AGG-ID: B8U6AH86OUO6uDK2Qj5exw_1791021145
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af5a07314so187568f8f.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021145; x=1791625945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bGwiD5BsIU7SMUvm8z3LsVJJc+9NsNqtDssS4ilkK84=;
        b=bKPEJjegf22xt7UE8YfEPOgMbyGJzt5CIs8Tc5Dpxgfd1wjBgZgKgUU4gbAXqmY5x7
         xwrd60yb0DLuTsdcLhT3haEj7DfRPe4U9q/jD2qBWWOFLVYe47GBPxRRrcIpGYnItU+j
         8fAUeFParZrJ9N4IjROpH1CaZ4VOuAM20WLfhAjCmfvUNLNMTPquguZVw5YDH3uwvcMI
         b3c5y9TqUGxT1wMIgykAapiAXFbJ/J23/ZZbQ9TJm3JD5cZhDd7wRvMUgXHPdsxxikgF
         hQmFPlMhqLJShzARM6CckGgJJdRsOwyt7D8o4J/HchNrSNVeJZr3BSkXmC9QvYHcDKLw
         RdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021145; x=1791625945;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGwiD5BsIU7SMUvm8z3LsVJJc+9NsNqtDssS4ilkK84=;
        b=i4+6/JfQY3F9clVlT1QhyqoRVgowZ9TuFowM8CBVWM+WSNK3fOG4PHQNY/bvveQ0Kd
         4Z22EWp6MiTrd2NOB/jq52TuUvBjipfNAFKiio40UTXRZpN73bvE/pTVxlCpEaOY3hRh
         ZeP9Vp482JsnUeRZYXexBdUGtJFB+UkujVKtf7+mz3RNa6X9LddJi+YkhAxC/7l9eiLu
         Ff9HDuxvgHM6CsBIzGlw0Fin2HZUMi4T8htAHFtgXz8UOjU31JFiGqNOFrOANls079oL
         No0WuHJPK1+MbLQ/PfvuF/YAHqcC6HKp9SJxRwYJl+fwqGrc97kn0w1xqewDOc9KlimO
         QAjQ==
X-Forwarded-Encrypted: i=1; AKwUvBy25stQNRmhRqIjdxgqKafz8bscXW6qaE/wv5PaYAG+iFw6iP8zRMK1mT7T7oo7Iz8vOX7Zbbo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpiFjZbjqfBoT2bO3DlyfO8Ju4z2QvamWo0UEjMPmQTL6sXR48
	frLo+FVmCcBLFC2bCB9ujdZ++HLp1QHJepKOsT8tZtFyv3RLkmjF+q19C9on8xv2FMcT+WwpGTY
	SEKvrUZ5F/Xec7drqlfy9KI6/1c4MS+tuD9LfyS8+3sGyhUZqx5CzU3EIZw==
X-Gm-Gg: AYBFou09FkG2o/j1KEWD2qhl6MjK2d+m0zMms1vhv5ijaaCTL4gJG/APg5aVUwsFncb
	Mkx6WMHBnCPPxxCm5tv9YsNUsZ4W9cfhSzrW6o2mLNLCE0McmJbLhEvs8QQ8urYjKpLIveBK/vR
	+o+YizVQxgObLs0fSY8E9ncraaf4wHHHgIcxJBpy94/2zvHvShTK4XXOBqoHQIKuvhu9AdFqtML
	ihpDJGH7e6tGKQ4Gjbfr+uWhpeObvTpYTAxFBQs4KZLBhPGzzkavgf84Uoy469XfazhHxX2DmOq
	rEniMTFFoysFycOlc6aZEb262gcU7mY6n1LC0B+B/5fDS9z75MBq5n2/5Cy6b9qPplg0M/gX/LG
	cFErepgPJLOHG7Xzu/83dsQH16pF83MrEB2qIeho=
X-Received: by 2002:a5d:64c9:0:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48b126f1596mr9932303f8f.7.1791021145348;
        Sat, 03 Oct 2026 02:52:25 -0700 (PDT)
X-Received: by 2002:a5d:64c9:0:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48b126f1596mr9932244f8f.7.1791021144825;
        Sat, 03 Oct 2026 02:52:24 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0613sm12752818f8f.13.2026.10.03.02.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:52:24 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:52:22 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_01/10=5D_ice=3A_replay_UDP?=
 =?US-ASCII?Q?_tunnel_ports_after_a_core_or_global_reset?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-2-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-2-poros@redhat.com>
Message-ID: <E2F0ABAB-6E8A-4672-8DCC-9F3C07E902A5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:43 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>A CORER, GLOBR or EMPR reloads the DDP package in ice_rebuild() and
>ice_init_pkg_hints() clears hw->tnl, so every offloaded VXLAN and GENEVE
>port is gone from both the boost TCAM and the driver table=2E The
>udp_tunnel_nic core is never told about it and still considers the ports
>programmed, so the Rx tunnel offloads silently stop working after the
>reset=2E With VXLAN port 4789 offloaded, 64 flows that differ only in the
>inner headers are spread over all six Rx queues of the test port by
>RSS, after a CORER they all land in a single queue, the same as without
>the port=2E Removing the port later trips the WARN_ON() in
>ice_destroy_tunnel() because its table entry is no longer valid:
>
>  WARNING: ice_flex_pipe=2Ec:524 at ice_udp_tunnel_unset_port+0x56/0x280 =
[ice]
>  ice 0000:04:00=2E3 enp4s0f3np3: Error removing UDP tunnel - -5
>  ice 0000:04:00=2E3 enp4s0f3np3: UDP tunnel port sync failed port 4789 t=
ype vxlan: -5
>
>Call udp_tunnel_nic_reset_ntf() once the main VSI is rebuilt so the core
>programs the ports again=2E A PF reset keeps the package and the table, s=
o
>it is left alone=2E No rtnl_lock is needed since commit 1ead7501094c
>("udp_tunnel: remove rtnl_lock dependency")=2E
>
>i40e fixed the same problem in commit 1f190d936948 ("i40e: Reprogram
>port offloads after reset")=2E
>
>Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_main=2Ec | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main=2Ec b/drivers/net/et=
hernet/intel/ice/ice_main=2Ec
>index 8c4b0fbc790644=2E=2Ef2121e79fca993 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_main=2Ec
>@@ -7859,8 +7859,11 @@ static void ice_rebuild(struct ice_pf *pf, enum ic=
e_reset_req reset_type)
> 		ice_rebuild_arfs(pf);
> 	}
>=20
>-	if (vsi && vsi->netdev)
>+	if (vsi && vsi->netdev) {
> 		netif_device_attach(vsi->netdev);
>+		if (reset_type !=3D ICE_RESET_PFR)
>+			udp_tunnel_nic_reset_ntf(vsi->netdev);
>+	}
>=20
> 	ice_update_pf_netdev_link(pf);
>=20

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

