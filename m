Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E09379EF7
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278830; cv=fail; b=KwR63IsRH7K63fsOeRVCjbAiSnE9dN/y2hv4mk6lAChU2HMs787YzTspBQ5GvvoASoAI6RkMi0guErM7wdbVhZlFSVLF8TaBshpjVDC0Lt6DVaLFu55bHpzkH3JFuy0SoSCm1rjBpjAox779jokrPtSpBdLh3igeYBIMfnehRMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278830; c=relaxed/simple;
	bh=YPeP6XwruQIVX/xIYqZ+PMNV66hlteumq57nwBnxRsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o3M13Zfya+ODYNejVRwaj7dkfz6sMH8g9+kaOfj4vUpOY/zUJ6hDmEpCVbCK2ChCNJLJWGHAsimI7v4M3iJCONCzOYITAmZ0QRHhXGvdwoAZjHHADkrBCffKNAnTNNlP2AhC4Fy0r3WV/ENY2+JTLVqJEFkHjVBrgMmPpqomBHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q6DVN/KM; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q6DVN/KM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dyr+esWlECC61OMmrdjyM0fRBOW/M8+e4oQBEwoJT55faF0tsX7pXoQNO4JuyvisQBT7KVr/WscrNcgXmkCY43getIA5c9Fm+EaDErJf9I8nIm1P48JuOWkeJEcaAokLkNe3vcQWdc3zAD9/HD60lzlVTFQENyp9PqfNytpL10dWwEyyhDMK9bLzB2KR3WSNhtpEz8WaxnB3D2QinxVOTWchFXHnB9Pc0daHDHHCHhoxfT77n3b+UAgSCtwxj+bdbzztfxAh/TO2Ux/KpOo4RC3LTJm/2xs1BxWqSWUx+I69U4P9AHe2bwlwAHGBJkBahTlkg8BBfl3S20+tq3mVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAlDrUprWBTxRkmwmOODNUyHgDxMacgYUO0wSxjHug0=;
 b=vr1upK0E6QAxMtIUpuM6yKfcI77gIiSGXAAlOlHB7JLLvah+7VPB7wdIi/AVmzecGMuP9sLEeO6wQeRnh/9rWOcmHo7Rv4JrrSbBZzAATySDtBcbrs1N4CFPgKNp6YbEuUAPf1/cTtZj6Aj78ovNXytrNOsnHej8wc0QXB4AQtj15su0YY97A0rmCfRYRj2ysbvTOAKYo/zvZqOty58HsYaYz7V5MGR4p1SqvkrDLhYBZi4JsJEnyiHohG/86n8eRdo2ONKNv8YmAk1/0fs1w64dKQNmPwf7UqafOAT77ABc2M67+KeK9G3y6ebW2BKliMmDocnjVTua7I7SCSUrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAlDrUprWBTxRkmwmOODNUyHgDxMacgYUO0wSxjHug0=;
 b=Q6DVN/KMkxJu3EqC9HR0Kw+UJdhWRiNF2oJVKJ4CYQ7ycJ2SOsQCDaJ99WjGbyIyqfkbvdVqfnuRECIhqnmUjrr8OFpzdRAi2Dznnhj157hPHfWKyaCweX8FhCG7CvIopzAX71JdaDujClDz2cZ3l+v30WbsxlJAv602DsXFsENmJbyoQi3m0XNSPKJbJrlUwkHS2eH5kCqqJ3xBTwmxzXlqHHoxmynp/t3HPocgdejVnnL7n6W16aXaHoqRgFAHKAyT5yCv7iWM7lhlOsynRH6F2g/tcl7YtuTzgIg4OGFud+TW81AQ0AbBoiAn61v9P0Cbw25z6lxV/BdvBy0v0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 12:33:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 12:33:44 +0000
Date: Sun, 9 Aug 2026 15:33:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: weir@nebusec.ai, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, petalzu987@gmail.com,
	tom@herbertland.com, vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] ip6_tunnel: snapshot encap in xmit
Message-ID: <20260809123335.GA2443083@shredder>
References: <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com>
 <20260808194001.853434-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808194001.853434-1-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: c96d7f01-9c7f-40ce-9bdd-08def61273d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	++TXxe+gl7wXohSpDaZTmXIliHW4vOKl1h1zFjx9O2R7E3oHlVtgul5rHHmF7HOGV6LbmP1Yppg9KZtZfTnkhOSspWUpNtIL9GRavQJW66q1DA/cC8QM6Bjt/ShBYjYN3H9lZ/ihMzhbbbXcfRr5rV7+E2BS4Lg6lF19QVN5xqlMf9k8SRgiFFE2tz/VVwBwYAbSMZIqRsruEzFW1OLjT9jLUCOq7L9sJZBKHMUa282tCk9jTxx1tHhpLbbmnLa2UFVYrh6f0DIZ3U1BoUKWnQ/YrxHoNJ7zpn8GGf7P87AIJK3z07/55Yed2lme0g3iKK2dEOrI7w7pU5TZGNO9brMLeGl/RT2qqWtDCBraUHFXqm5iqDq6Ks0op8tp2x9fTBrAfKtUqS4dqi8rd75BzMCQDZgRJsysXU4T0Q2kjraQp7eVIQt0QiZg1A4FmZwEnvGQmXxzgNT8cvbUeN2Oyd+RJGb5zeVXmZQGaP/ACRjW+stmtiu5wEU6eUPArbemaaWPaJ5SO/zbLn0EWqrLG6uzCsqVluJp+D5PBlRmToPYSPFStIHe4tpX2ufu3SKb3usZS7Hks0L8EMymERy61nXlc+eluznrd6KGO6scUEgNQ9CrVfIn6pui4WLt0pgmUJaevafQ8Rhw7YT+dlYK9LfZ5DMg5cVQO2GajcbyKsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znjhKaW8kMflv9ECQY5/pljVL7wRkJaU1L66vUFNqR8kYkp4mfEnio64Uo90?=
 =?us-ascii?Q?V0zRgsHjOC6AEhDHAkvUvG0HXQ9D4U0jvb3BWFlcYc5W5wy8ADng+XrsdRKR?=
 =?us-ascii?Q?jcIdWDKstCA344sFf2EqVeOU+UtTDQ07gXTVbmALdlNH/5KjKe7hm5apv3/n?=
 =?us-ascii?Q?duhjadLoZkCZqvLnSG1D3o5OOGNKMBIn4OTPOwnqN3wB7kwBp0U2fqPWxpwr?=
 =?us-ascii?Q?B6kWJqCp1kt8aFWrlwWYT6XF1RD0bEkEnO4uD2sI7wZKMmSsRIlPW4wh4RXj?=
 =?us-ascii?Q?JdLF0svLyU08+H++yX2QlcYYybrx93EWUJ9AXI4OQ2BYZoU05+HXJxHAxBQC?=
 =?us-ascii?Q?lOJjjOQBT1tEWat3roh20jUWo4+fxWCUxTi3OwxaZLaIHezWVi0cJWGCYbRu?=
 =?us-ascii?Q?7KLuPRvEsUDxyym5X4txPlVt3lEq8PCsBgkMD7BGgFmYFxlFq9peydcKlJgF?=
 =?us-ascii?Q?jvTpAY/johWogvb5BuQ0b2Pi5tkO/B84uG3kqtVBVu0Bo5c9//KiyfOK5d6X?=
 =?us-ascii?Q?Wj8m51fWA1yysESd2SyunF4xxWBOM7Y2wHjqolYwEMs5t3piSm82qiiK32sE?=
 =?us-ascii?Q?Yg6htkkhBexJcgQlobOdgxG0lDNIQcf4gX+YXxaIFVnHJz0QI13aDB9ICxB0?=
 =?us-ascii?Q?tM6gZM0qVUzsqWhd1dHy67uKhK99EuB/mxQuhRJWjtisaFAnodmRVbxEz6QJ?=
 =?us-ascii?Q?nt9sJDQaraRFqsBehoOlIDRTTjOM3WwBiXbZiy3razgYOPDK1bHStXMgCsFb?=
 =?us-ascii?Q?8VvG0b0N3rzjnxWtmGCbUPgbn6f58yQyJoI82A6TzGxffnE1RxDPa3HKcpUD?=
 =?us-ascii?Q?O2jpp5J57WVaNh8z6auMWWfYoGYcK8H0EcsoJvqk6oyMcPLL79m2fSz53N4O?=
 =?us-ascii?Q?1/7/nB99XEdGx/Hb1LKCo+vCd58vaxYsMG0nI4UfuVyABXnajvV3R1b4nlAU?=
 =?us-ascii?Q?B05MRfzJBZXuxFipxo44ipiflwGYR8DQ1X6/1iGTluScz0qUfFwKLeOEil1Q?=
 =?us-ascii?Q?TlKW3E4yHcCcnvy0OfndqC4mtS+/54WM0Do8ckRr5FGP2Uii3m9bSoqSEMpo?=
 =?us-ascii?Q?TjeEOfa6IPJm5kkCkkpfsW5zRqwzPvs0oa600rElggGoZ5uLc4lKmX5nkeJf?=
 =?us-ascii?Q?k4opM60wVb5DnRGle57Z1+WUMCSrNkEecOH/QGQ6olgK3OEEnwWpm0rpvB0I?=
 =?us-ascii?Q?gl5Oym20y4ky31sLATG2dAW1pCv3XehPYLFWWIKZ4AIDU6m6FxIlelVJ/Yew?=
 =?us-ascii?Q?XI+57hbxKTOj/rKRc/5DEZa75myEb7Rlef+X4OmSK8KK68Ly1fWlQ8XYzWGK?=
 =?us-ascii?Q?uaXHxMcxq0MfIJ0d/uEBqLM9FHdtQ08npNR0kuOjC3Cmp5gS0jI0JTeD4qn9?=
 =?us-ascii?Q?HKyPfJI88JqJUfKeylOow8kSCzUeiuC4XJkH7D0yXYKFStmAbtI1uXXak2bv?=
 =?us-ascii?Q?5dyux72glQ4WOw/6S9jn4lOaWK+4FQi0EQavMTxXO/viqNiR+nqnmWB3Z3F3?=
 =?us-ascii?Q?6bY1MPfh2Mfn7b0k9QhhkFV+J1w6pw9Gvqvm7lM76oBIKFjAXVR+78A2cAXi?=
 =?us-ascii?Q?jZZ1+ljQPuMTzwc3GymKwJhj2BPO83tcHi9wFvMi/PA+sBQpRq7+DlWupxDU?=
 =?us-ascii?Q?qdHFbj8Q94FmOCY7ux4hzerOdeUuLQYG6qFu5GHqYZcvjgsPo1Vnmx4V8Jw/?=
 =?us-ascii?Q?F0LiTl7ssGIhc+R4fGfEfVMsjnABzGkqLEpAPAbMt8pMVxsS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96d7f01-9c7f-40ce-9bdd-08def61273d4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 12:33:44.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq85kclOZQENHf9FfIs76TWI9shGz7B2qdWMThF4kbTGlkxGL/rJhwg0UwAjRPUiEvNoBMeyCF2SFkSjwJTMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

On Sat, Aug 08, 2026 at 07:38:52PM +0000, Kuniyuki Iwashima wrote:
> From: Ren Wei <weir@nebusec.ai>
> Date: Sat,  8 Aug 2026 16:40:49 +0800
> > From: Zixuan Chai <petalzu987@gmail.com>
> > 
> > ip6_tnl_changelink() can update encapsulation parameters while the
> > netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> > headroom with t->encap_hlen and later build an encapsulation header from
> > the live t->encap. A concurrent update can change the encapsulation
> > header between these accesses and make skb_push() underflow the skb head.
> > 
> > Take a local snapshot of t->encap before calculating the encapsulation
> > header length.
> 
> This intorduce per-skb cost in the fast path for unlikely changelink.

Assuming the common case where the tunnel doesn't use fou / gue
encapsulation, the added cost is one compare and a copy of 8 bytes.

> 
> Right approach is to convert it to RCU pointer (and remove
> synchronize_net() there).
> 
> 0ba269933f73 geneve: convert config to RCU-protected pointer
> 777434f53e77 geneve: pass geneve_config pointer to helper functions

It's on my TODO list since last week, but I don't have the time to work
on it right now. It's a very large change (see the geneve change) that
is needed across all the IP tunnels, not something that I consider
suitable for net.

What are you proposing for net?
