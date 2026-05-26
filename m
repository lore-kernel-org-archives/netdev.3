Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D633AB28E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779146; cv=none; b=nnZEOkDkHhTZx8m7IYLJ4Ab6c27xTJKZwyB0Mj9igVF/R8o1PQktxTwf9MqnpxpT0V85XP2cvYBvv/TqfKI/8m8l2KQNQcxCc7xVivj2MS1Ym6lfsfhqsmsn6b5eDG9b5x/0/V4skubZBiKzl143B4RWIYIUC3txD2SCRhY+zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779146; c=relaxed/simple;
	bh=NNcs+u4d8bGicWA186pgTUATqthS+YFjvgIepfLCFuc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QdeFdrgg6BRWG+aoYjiu2cC3bnOqJADKKesLDWWlIAXk7piyeRsxNYXTQywk9NitoSMHcX2Sfa1jnrDjEUGY2j3GDCNVQptdvYfXddcfdBmb3L+AOTLEs86zFIg+4pKdkmlvlK6oYj/uS3t8hSC0yFg1tUOBmHO7quDObzj3K/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=f0dg7uC+; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="f0dg7uC+"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64Q75Sdc010496
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 May 2026 08:05:31 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64Q75Sdc010496
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779779135; bh=NNcs+u4d8bGicWA186pgTUATqthS+YFjvgIepfLCFuc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=f0dg7uC+1gI/nD95l033P8+xblEFCC19AN/0CyTFO3aQKFPwbrXacGVmSM1gTeLKx
	 1uuJa2S+1z9NIv/7D+qi8bOloWNWz+AYQAgsJnbkkSw/kkxqk0wbqqfi933LUpKpgb
	 b4mAv5InvOwXW2SIK+DcTblrpEl1ThSc6f2WzQBe8WNDX3roSOtCfe0HSwaPgkM717
	 LxOsH7kgXUldnAps1yxy6W50nrGn0SWlr37erXZkUwvrQYLVaq3CPISAuTB+y9wWX6
	 0hkxFKB97oFVXClvMx9OyTYLggIz05fWkSzH61Fy4FsZU45uNYBz/v17vrovwt0/HV
	 OzjrnMlfVMCKQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [RFC net-next 3/5] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <DE4F4AC6-2783-4374-A4F8-3032B32DB848@padl.com>
Date: Tue, 26 May 2026 17:05:17 +1000
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4CE6A53-C253-461A-A845-DCD620D7D97A@padl.com>
References: <20250927070724.734933-1-lukeh@padl.com>
 <20250927070724.734933-4-lukeh@padl.com>
 <79953e8f-a744-457b-b6b8-fa7147d1cbf5@lunn.ch>
 <B2B00AEE-521F-48D1-8290-18A771986AF4@padl.com>
 <d2d289ca-b40c-4e83-8fb6-ccf53d572642@lunn.ch>
 <DE4F4AC6-2783-4374-A4F8-3032B32DB848@padl.com>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi Andrew,

> On 28 Sep 2025, at 04:14, Luke Howard <lukeh@padl.com> wrote:
>=20
> I guess we need a new attribute or flag when adding a MDB or FDB =
entry, and also a way to indicate that a TC is SRP-managed. The kernel =
bridge could then be modified to reject or reclassify packets that are =
classified into a TC with the SRP flag set, unless a MDB/FDB entry =
exists for the DA that also has that flag set.

I have looked into this once more (disclosure: this time, LLM-aided).

* adding a MDB entry can now take a nested MDBE_ATTR_FLAGS attribute; =
the only one defined is MDB_FLAGS_STREAM_RESERVED
* this is propagated to MDB_PG_FLAGS_STREAM_RESERVED in =
br_mdb_config=E2=80=99s pg_flags
* MDB_PG_FLAGS_STREAM_RESERVED is propagated, in turn, to =
SWITCHDEV_MDB_F_STREAM_RESERVED

I intentionally avoided FDB entries as they=E2=80=99re not typically =
used in AVB/TSN, and this would have involved more intrusive API changes =
(port_fdb_add takes just the address/VID as distinct parameters).

If mv88e6xxx_port_mdb_add() is called with =
SWITCHDEV_MDB_F_STREAM_RESERVED set, it adds the ATU entry as =
MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_AVB_NRL instead of =
MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC. For a given destination MAC, the =
AVB_NRL state must match across ports (otherwise -EINVAL is returned).

For the software bridge, if a frame arrives with PCP 3 or 2 (Class A/B =
traffic per IEEE 802.1Q-2018 Annex L) and the destination MDB entry has =
at least one port group marked STREAM_RESERVED, the unflagged port =
groups are skipped and router ports are suppressed. MDB entries with no =
flagged port groups follow the existing br_multicast_flood() path =
unchanged. The PCP set is hard-coded for now as an example and probably =
needs a configuration knob.

Cheers,
Luke=
