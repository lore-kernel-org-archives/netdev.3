Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E548264A9D
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783790803; cv=none; b=eeXhx0cyOlSVi0znZ6mjXAWWGePPGVjDQiKoecZLwoa2YkuxrmAl/GDnktJslftwNR4GNkoDVkgB24/6Cjhz5kXJ/dSpOXr3BltO8d3lBdwYwfLn5NPiQ/+Kq4IM0r5SF5miYowCB98qj+LYiCD7k7EdXBRqXMeWMjQ03qDFyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783790803; c=relaxed/simple;
	bh=Q0Wo9fqOlwiUoztrOV19DWqZEOTyyRTemiA3wvQl9tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWQUYWnhotfy8F1k/YpdUy/v6OHngMVPbncCXWZFrAjV/bnRR76Ss7USGMr4XaZSlfbZhgfmKJHkKmvTvYOsTkAQdmztpDhuBlbnavzBjXpsfxWfYhfawhjMU/t+PWnnwiNFoUxENruWCbUCrCT339/gMpw+jtMsXpdmeDlg2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv536ZJB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv536ZJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE171F000E9;
	Sat, 11 Jul 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783790801;
	bh=aHASofmu20K2NKxFgMlnzoNMybx4BFgUsb0wVxnt2TU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lv536ZJB0Zxz7eWBR6AbnZUSbJPn/1Qd5Fsj2Ko9+NryCt9+GpiOrgrvQfTEZOjGa
	 R91KyvdFr+PTwwSGMHOs+QyAL0kFmhAiG0c9tC8xnCBipj/z+ahLcsGtAEsIjllpMH
	 7ZlZGLQAcOtNdodPhfMADX/znwzFWdxHXDhdnGJKmNR8fghQ05eoOQ43WsJ0EYrfiY
	 qho5BT0BZpMrjwLD2iPom1BtgR6b/xLwIyYo05iPF0LpXlWChOnozCRP7fti3DogUO
	 hN6urQ51QINT6qbemPPb8mTRGbfrVikUuxP9uUfAehCd/FesToTJ9al6UkmBRCvloT
	 9j6IdD5qcbDAQ==
Message-ID: <c2a799e1-6077-43f9-b5ba-6380a440bbec@kernel.org>
Date: Sat, 11 Jul 2026 11:26:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI
 feasibility
Content-Language: en-US
To: Jack Ma <jack4it@hotmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Roopa Prabhu <roopa@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <BL3PR17MB6067BF1D5802A6B1822452EEE5FD2@BL3PR17MB6067.namprd17.prod.outlook.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <BL3PR17MB6067BF1D5802A6B1822452EEE5FD2@BL3PR17MB6067.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/26 11:30 PM, Jack Ma wrote:
> Hi David, Ido, Roopa,
> 
> I am using VXLAN FDB nexthop groups ( ip nexthop add ... fdb ,
> followed by  bridge fdb add ... nhid ) to implement L2 ECMP across
> a set of HA endpoints.
> 
> In my design, each leg is a distinct (VTEP IP, UDP destination port)
> pair. Several endpoints live behind the same node IP and are
> disambiguated by the VXLAN UDP destination port.
> 
> Reading the current code (v6.12), it looks like an FDB nexthop can
> carry only a gateway IP, so a per-leg port cannot be expressed:
> 
> •  vxlan_fdb_nh_path_select()  copies only  nhc_gw  into the synthetic
>  rdst ;  remote_port  and  remote_vni  remain zero
> ( include/net/vxlan.h ).
> •  vxlan_xmit_one()  then falls back to the device-wide port:
>  dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port 
> ( drivers/net/vxlan/vxlan_core.c ).
> •  rtm_to_nh_config()  rejects  NHA_ENCAP  and  NHA_OIF  on FDB
> nexthops:
>  Fdb attribute can not be used with encap, oif or blackhole 
> ( net/ipv4/nexthop.c ).
> •  vxlan_fdb_parse()  rejects  NDA_PORT ,  NDA_VNI , and  NDA_IFINDEX 
> when  NDA_NH_ID  is present:
>  DST, VNI, ifindex and port are mutually exclusive with NH_ID 
> 
> The original commits, 38428d68719c ("nexthop: support for fdb ecmp
> nexthops") and 1274e1cc4226 ("vxlan: ecmp support for mac fdb
> entries"), say "these nexthops only have ip." This matches the EVPN
> multihoming use case, where every VTEP in the segment shares one UDP
> destination port.

The first commit was 6 years ago; those brain cells have been recycled.
:-) I suspect there was no reason to consider different UDP port per
leg. Roopa: does that sound right?


> 
> My questions:
> 
> 1. Was IP-only a deliberate scoping decision for the EVPN-MH use
> case, or is there a deeper reason why a per-nexthop UDP destination
> port and VNI could not be carried on an FDB nexthop, for example
> through  NHA_ENCAP  or lwtunnel, which route nexthops already
> accept?
> 2. If legs genuinely need distinct UDP destination ports, is the
> per-remote  rdst  path ( bridge fdb ... dst ... port ... ) the
> intended mechanism, with the understanding that it provides
> head-end replication semantics rather than nexthop-object ECMP?
> 3. Would you be open in principle to a patch that lets an FDB
> nexthop carry a per-nexthop destination port and VNI? If so, I
> would be happy to prototype it as an RFC.
> 

It seems reasonable to me.
