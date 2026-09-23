Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789430F535;
	Wed, 23 Sep 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178098; cv=fail; b=lSvcoN50g3g76MaFhJSFD6j9qN30y3ut3x+lmntf7bxVvGCuIUzSm2hLO1dOwKfzEjxPEpBjFZhaoXIkfiHV03cjHynNHAgVK4Oa/1MMcvh+KrIPSx2UzBD08RM1OhyKSErpzn6lisJSVw2WKNE4tqTEgMWMyMKG8BEeokBWbrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178098; c=relaxed/simple;
	bh=cy8fMuoVhjau/isnjx9MnPvd9qneA1XiblfkjSG3ApI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hmrJyv3TOwN19572WYBd+zlkCNs63gJnnj66Ey7J1xrHK9qntOfDKb0KLUTjxWeoTluvPMpha3rBghf3ka6rpTbLobB5PpndGxWMR7VsrQ1f3f1k0ABpSnGWm9x4XNLVf9JPSvs5m/EU0pHJzspBeQwHkcqZ07ILOSzds8Ti+qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oCSHIac5; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCSHIac5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU/e0F3YNr02VriW60/i+vPyfyf+cV8iM4Le0gIxmqHnLL3WkO34YsmqGcgKwe2ez5GGkyaO7tecX+Us6W4Urn96c4TLffpcJG7sPvV9/bE1vgY9CKSj23VYqTvMhIR8UNn7Un7nEd6PjI6hpbIs3wjkuuRp9twrI9CEkJcBm1dBYkOhNnSbrFl2LTiDu1AL+sq7ZfRcfqsM/QP/iSROzJVIrIoWvObc0RBjcDBNeyvJfim85e4ySMlL5CFfQ8po7lhf0+35AeNrHVXB4/sLyud2vLE0MFgxWsovYIbOdK5igwIuicm8+P/7XnXQ9XJrb+Q/rtbsEFXV6n5sygrT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPcU+u+Oaj614ZieVgmnKfm0CvygSUlB0/cXWGLdRLk=;
 b=p3DhzzIUJLfdk+NRXbmSz6ARUjMdIuRPFPz0+XDpN1+DOICI69KtsWisktGTkAk3bPbREtvoRlA+C3uWT8odJPfV0g/a3itH5S4nHvUXEO+y7CjJ0guWRVp4qertRQCVPjsJnvHnacYradIL3S3Dm65VBvgMmKmwWHmRp50jnim8P2LiYHbEavSHClUC9Zi3XEzbV5oOyEvpDyzymuDywN3qWVqmXAPeOTGvPd75Y6fiTJjAsVGAOam7GExj08B2OQNoQ2+3THnW+hxX1tFZjqto1EWCTMYg50hkaf3bkQpHMnZs3OtamlG/NR5l9qKBvdMQbpfG9Tq6HotTOSR4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPcU+u+Oaj614ZieVgmnKfm0CvygSUlB0/cXWGLdRLk=;
 b=oCSHIac52/RXt5drYlOcjnXjVbZ8Hqq3bRUmPtUbfejSBEKAdPc0wSN7vv+SNiGCb3LbUZSDVDDNGVzobk6XfEihiRJGSR6zi/A1e3buwY5nLFe1/KfYeeH/OzUJSlHatkVhI6Ax8AwhtPVl/MB13vurbI+eibxicqXmEn+lq+JVNAFy4NRNYeaohYGoXEICgqwwvlA5vXJx0uVBwRwtkLmKS3Xg2aXA4FKijLh2JkBgKwKtSDviwHfgf6sO3jToa9dBRMVl3i4fnFJxHQNFkiiPFX9lSqiCNYbLNpe4VLffK4SdL/povUSW7phBVzfAWoTmBV/xROhb8TztPeunlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:41:30 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:41:29 +0000
Date: Wed, 23 Sep 2026 18:41:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 04/10] ip_tunnel: add
 __iptunnel_pull_header_reason()
Message-ID: <20260923154114.GA2880695@shredder>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
 <20260922221507.3268127-5-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922221507.3268127-5-littlesmilingcloud@gmail.com>
X-ClientProxiedBy: FR3P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: f56290d2-d41a-4a2e-01d2-08df1989228b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|3023799007|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ym4pAdZr3ErbH1bFXCSD4wQDr4ptKtu7KE1y/BhvbjrIsAJsvjQvLQcNF/obX17ERqC/q/ox7P6YmTdsCIM1bkI9Zry0zEVFY85Js6GHjyQAiQsk0joIinmVWcFgb9voVOsd0KZcePnh+Vxv4c2azi94Xc3bFunWqXQT1wTK6zQNEBFtbWEQ2IACSdGJMkU/sZY4cUKFsD5DwynbBBb7FJM/c0QYhPMJFRS9HYAfz2UHYoU9XWhGN86MTXzZsuKkFh1m2JM0fSlWQDHIAWOCUfKaLb+ZuHU+UY5TL1z+LFORxdgY/RVNsgj2v1WIPk581yTOB+CJC0TkqxCrYIxIpzINGSWkh7BtZrmLy3bik2lzVorhP5VJZMqVB12C5adfsS2O+qyXf/XdoiYZpLmMFlzfrG71+VATgNtZ0Zv/t65rf7DsTbfXkRCvrgsTDqb3O0eKBRxZ6BDP2OydZJiW4j24aPYRRQ6rePPBpnYabaAsntjfr/s/RGPrcTz1lzIU9L5UKmgkBRKNSvh3aJ3aeHLjZp3F0SqVkRhZ/O6qFDvrIOkytRwv2sRsSFoLZGuD+EKu44e7dxv1g32XpB29JK6dkylGjMXAu2Rw2Izse24QECA6ENiGSwFH5zz/M4ZYHOubTRGqvuk+Fz1mxbpdp81BbliI0LFRC4tpRANCVD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwhwcC9U92YJ/tE2SbBAWlulq0OvCjL4on198OgDTMfYFV+CXGfDMTqO9fUP?=
 =?us-ascii?Q?Hjg4PsHhkMlNErhf9QrOAbNqizu1r2P/+l9T6m8zLpxfwEn8U6eSnFEABfO+?=
 =?us-ascii?Q?WqewmkRB3wG4jdzVX+KP4oyQQdeFi8uUuc0YgOElvZ1q9iYnxENNPjwGJGEN?=
 =?us-ascii?Q?Ae0cUy8yHgdtbKNJoOcb7hV+zrVNobxxO7KKv5j8tdoXl3pdD8USdGnXyNee?=
 =?us-ascii?Q?WtW0fHNBf8jC844m37ysoM6I63mq3OhYilyKrkWGrscW8y637pfvkyw7Finy?=
 =?us-ascii?Q?8v1zLaFLs/TiOF16TaMj/fdKXSyjWojIDAmGPgw3IQqCltPbD9GQfp6/5n9L?=
 =?us-ascii?Q?XXAO8cm2mUYEihYIqkSl5KBOs+HPKrzGEu9gc6d/cuNR47Mz/07FCsBNhpo8?=
 =?us-ascii?Q?+5sA9+W4ceubJahhISSlCK9UfL8qPM6VqQawsbAEcj75gk0kXo7/NJRau7fo?=
 =?us-ascii?Q?ezE5STezje4SXWwZp9U/6ljYbb/K8WND+8pIaezmEZ9dz1u9ieLAhIeOi7V5?=
 =?us-ascii?Q?jzME7S22Ll9aSPUNa6pfl4r2a+bz1Ghnr4NqGQD2gcwVoFU11RcelI1j9uUT?=
 =?us-ascii?Q?4yazNlbwCZfz5bHHWAhhyrNpIttENKkGpFQYcicsiTvNDTFkorbXhfvmTm5q?=
 =?us-ascii?Q?D7/fVD5fWAgbnxVuD4gakaSZK9JcRDbPkI/cEMaXqZ58smQK1ADwKya7mohE?=
 =?us-ascii?Q?GitJ0ez4wlJi1e8cSjAXoRWrj+u4Q1MDoBTzR+a5ODecWDsrcxYaHdH15QgO?=
 =?us-ascii?Q?MdlnS8O4Vx3M28PeCnQgPdb5ql7QVh6TNsFea+WLPs2Si5TWEMWhbaZMXkVO?=
 =?us-ascii?Q?ltFarso8s79aJldSLByFK/nXD3f81yQezlcjwrCrz7HPqbttp+tQ9DBIRZy7?=
 =?us-ascii?Q?fDwLtqy0rFUs8JSZwGnTurZ03SXp1MRMN8WJoi30nQZKnybToC/jDSoO3o69?=
 =?us-ascii?Q?xIHrmt05CaaFiSeGislXoNebNYIcqTtNUVjxAozf4YCKxwGinxLyWXCF88X8?=
 =?us-ascii?Q?Ryp8fGljW24hc8TuMLAkCb3dTnq+qc2Ld65TjvgoQ+TZyC981THsPu/5N856?=
 =?us-ascii?Q?d/xOM/O5PiqmUisY5ScrepIqe4ZjU712MOiaHXfa6K2wA/wka82JbkWQNRPw?=
 =?us-ascii?Q?U0B47QN3HvCXEu03/ZdOgO8SYEDsxbaRzGyLdy5cHlysD6VlKdh+/lnO/W46?=
 =?us-ascii?Q?o7t89EWmMazzL6PvbJtE/4T58MkjFv0SoWFrAtOKNP4ZnDK8Qh/bB4FA9XR7?=
 =?us-ascii?Q?9s8pnxnpzeQPJDfzw5BnzBkWrWVFCdXnfBXO+1YmooJstE2aomzBI4r4PF6F?=
 =?us-ascii?Q?uCSlW96+7BQdG3C+M2DU+1E22mBH+S9Knf3NZQbuw8jVaZJrF2G+fA9PydRn?=
 =?us-ascii?Q?B+TTvm/AA00DgA79+mxjCqmoIdkJx8npd/AERZltrWfb9RA8sQzu7Ycym16R?=
 =?us-ascii?Q?gPC/dB9+CACIOEXW9uRlfMIw8S2x/C5aDc99gmZPIsWuc4rhvyE2lHl6ew69?=
 =?us-ascii?Q?Hdi6qAMPRc0Wanfx1zXuJ+GdXQXsbCmt7vxodPHumJ2V8BWNb+/VDhMKUFSV?=
 =?us-ascii?Q?wLAUZ0Q7UXOFcn5tFE77DLUtDdO32Rpe3eiGZATM7H4GhAxnatq/dIJuqjHE?=
 =?us-ascii?Q?Q17Xa81lzXV7mwJ/NhN47gXApU1GhOg2WT3Dps5kHisHRCeUAYq2v0o7zq3y?=
 =?us-ascii?Q?Uhih2Ucj+VFaGb5emxbPXZ63QiDKl8cNGAjqcK/6HpJUx0ou?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56290d2-d41a-4a2e-01d2-08df1989228b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:41:29.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIw89blxl9F1KJDiv9SJ5tCX1vB65ozxedYy/3yeYGUTcV58k7P6cy7LgdoHBI22Ayj9soJrWr0XZuSUWFeBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

On Wed, Sep 23, 2026 at 01:15:01AM +0300, Anton Danilov wrote:
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7102aa11fae2..c68031d01c39 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -614,8 +614,17 @@ static inline u8 ip_tunnel_ecn_encap(u8 tos, const struct iphdr *iph,
>  	return INET_ECN_encapsulate(tos, inner);
>  }
>  
> -int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
> -			   __be16 inner_proto, bool raw_proto, bool xnet);
> +enum skb_drop_reason
> +__iptunnel_pull_header_reason(struct sk_buff *skb, int hdr_len,
> +			      __be16 inner_proto, bool raw_proto, bool xnet);
> +
> +static inline int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
> +					 __be16 inner_proto, bool raw_proto,
> +					 bool xnet)
> +{
> +	return __iptunnel_pull_header_reason(skb, hdr_len, inner_proto,
> +					     raw_proto, xnet) ? -ENOMEM : 0;
> +}

Either append patches to this series or as a follow-up, after this
series the only caller of __iptunnel_pull_header() other than
iptunnel_pull_header() is the VXLAN driver and it should be converted to
report the actual drop reason instead of NOMEM:

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 347245cc1de4..5c429a70987e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1720,11 +1720,11 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		raw_proto = true;
 	}
 
-	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
-				   !net_eq(vxlan->net, dev_net(vxlan->dev)))) {
-		reason = SKB_DROP_REASON_NOMEM;
+	reason = __iptunnel_pull_header_reason(skb, VXLAN_HLEN, protocol,
+					       raw_proto,
+					       !net_eq(vxlan->net, dev_net(vxlan->dev)));
+	if (reason)
 		goto drop;
-	}
 
 	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_RX) {
 		reason = vxlan_remcsum(skb, vxlan->cfg.flags);

Then remove __iptunnel_pull_header():

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 27a9e097996b..a94dadfa81f2 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -614,18 +614,11 @@ enum skb_drop_reason
 __iptunnel_pull_header_reason(struct sk_buff *skb, int hdr_len,
 			      __be16 inner_proto, bool raw_proto, bool xnet);
 
-static inline int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
-					 __be16 inner_proto, bool raw_proto,
-					 bool xnet)
+static inline bool iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
+					__be16 inner_proto, bool xnet)
 {
-	return __iptunnel_pull_header_reason(skb, hdr_len, inner_proto,
-					     raw_proto, xnet) ? -ENOMEM : 0;
-}
-
-static inline int iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
-				       __be16 inner_proto, bool xnet)
-{
-	return __iptunnel_pull_header(skb, hdr_len, inner_proto, false, xnet);
+	return __iptunnel_pull_header_reason(skb, hdr_len, inner_proto, false,
+					     xnet) != SKB_NOT_DROPPED_YET;
 }
 
 void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,

