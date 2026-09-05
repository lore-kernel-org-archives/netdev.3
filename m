Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6935200F;
	Sat,  5 Sep 2026 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788652374; cv=fail; b=KQ15Z77vIOcu+sZ1wMHCbSIIx0kECb3FIdFddW3lvPojFB6t8u3pnirugxb2/wmiPKyUWAryB4RKlN2/Mob6JrNGEHN0RiVtFKJtcdYEBdxfhwcTMUblQDAdC4ilzjKpJYmF/EWafyfqSLwZOnowTelbMKCifoTLLu9C09FV44k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788652374; c=relaxed/simple;
	bh=CdbRxdFvoOk/bsHZYkGR/vrwSbgjn3JhxsDKLODji9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdTxM7+GB0YBhyTVxFMpYWaClSIvWh38FmS8IU5x3hG+Bv+VdwyC4xO1AqE0c6zx9u0+9640sbWpCI2/VmjefxCcl+/AvjWgQRHqVHONEiA1W9FcuwdmnhN73bAMZNp0FD6sXX2YMNcGTBkbzRtzqWk1NrD6pt4ZfQ5HghLoAXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQjVzLxl; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SQjVzLxl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUC309Q7rQBIPSQk3ICh+gk7zQCNJiUfTY+LpfEust6ETMdOHPacqschGs6KLPugm4RMr8xr2dQsRwsR8FClAdqgbzDLQiNgIsUe/ugCUSHnUR6IHG6Knw2kZxrpeRiCsU5cRtmWeks4DK2sHLDcjMgHFVTA8NAaqANeBPFVSlbTTqkynRnxx4xVPTw2g8dgyV4xiIKWoiMAs4veVJSYmpCh9K/N67X7v7Np+15MZGUrwfFjK2YYWrqbEFGyZainvb7smyjjDlAM4nfkTET+TAJLN+TbTP7fRvgWIZEo8nvkKzBuxZSZfROKgeHo0DHlcQ6fFHo0TaL/aWe8ItqyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43AYT6EtUtCdopr8nBPbAdfQAqtwZ8vZqefdxqOANgQ=;
 b=dt7UdDdOCIIVzc/ZFLhEBn/0P5EdQFXxS+WDGMVZqwY5beU8OAt4QchW1k3H+rDhBKtFiRYo7jhvaGB6waELZPfNxFuJQeqfWD1uZ8dPzZZedhNKwNFvFhKsvpWjj+dGTrKmqH+X8+JD0KezpWfAwM5iw5rkaBSfJlXDUtcVrsJqenGl874tEjTvNx/JLupZmEEG5t11c4ld7tIs7yhXI8fYzQygTFE0Ea4Hh2IwlR3+wK9L03OV59JnXRJO8az89c/NJ+8SFFq1ozY0RadRn6Nge4WCiQ3qTG2Xq8HIZ17dQYdK12QxwXJIP8tZIRFA5C9TPWGX+OACKBe0h+dmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43AYT6EtUtCdopr8nBPbAdfQAqtwZ8vZqefdxqOANgQ=;
 b=SQjVzLxlCBOavTRgx15PqGV3BO0UcIEdWq0h5yrTiFrfh+s6oBiom6kDxay1etYtJ4vCL3z1Liejtwbg9DTvT6xFN6nuP/eTHvMT/+2wfD9dNNdf5wP5LzL8IT9qeK5N7A2PoQ9vVsiPk0Egy0icyXKZ1feFJD3hIBdZoLUWLbz4fap69MvUzsaV3GmoJzGQguCHdSZQY50cpjFRsD5U35mUO1R9VB+PbUz2QKAJ2YcX/oHMq3QmLRldJ3W/tU2BWksyKeJvdN1hAfJjXCZNgm8r2cgl+Ou0zzxbCrk9QefvC3QtJYexOHjDJL4DNEleZLf0bl/0i5/Znyl+3TYnwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sat, 5 Sep
 2026 23:52:46 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 23:52:46 +0000
Date: Sat, 5 Sep 2026 19:52:44 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Message-ID: <apyrTFlAsrifzqzB@yury>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
 <20260905183245.GD40544@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905183245.GD40544@horms.kernel.org>
X-ClientProxiedBy: BN9PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:408:f4::18) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: a572a9d3-dfb7-4a48-5679-08df0ba8c8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	OnktECSQmsleI/V5VtkjV/A48T4ms2YzXreJWQrmIYcLTDRLqQC3/4CR1XAYCU1NHzM3EUWTgfZLtqhe2sn1TbbLwpzxrW0+mZ0sDmWjMUupQBDJEB9GOi7PyzH/p3MGTOWsSrIvXcjNMzHfIC/64966D2k1ylMEn/s+ORaZxbg8RFZbb2d0Qe5bqLwWnCgYO9lEC6DASfizkHUYVb1z9+CIskjBitqV7c/nhDknwzVmU3PiP0jSeFdTbjNfURqaoK9hCaelHbpWJkE1fFAkptl+24EGZmlfY25XSkjeHAGRqHY+f0jRy1aAw1AgzO/N7CVBMsrxeJNMH5nQN13oQSgq8QhBlknyD0wDQmPiUArMza9hUs0f5y6iFSfN96Lsi51RvtpIZVKCon4j7xpkRZrFoLMOeqTYC5jxtlUPy3dFW6SyW6YiSASrru4oElmxs+DrG7pcvdQZvIq/ElEeuq6zL6DEMRgaGcGK/itcSAfqgRi7BJZKAdsIg41/274B5sEunXCTssVvqP3wz9q/N8BOuVZetSWGgL4TzAmcFDTWaF5Y76YP2jiX7MrsKvxiMtpb3+FFxq1SYWfpRpjwQozC+s2Y/9lcu/HtqM4XsAPuWWGrwWunOpgNMb9wkGjFQfCFDnLsZy81NXGAIXeMyWh6QGSRv8I3qit/6mPc6nc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHq2vWylKw0lcRFTfcqHJZhp4wcNjtImB0CSP+OLhJSdGhSyZcNKDJyISc/A?=
 =?us-ascii?Q?wBnbzLJyyxW6YHDmAo1MYr8xSl0lQ/kBZ96eu58bydW4cc6/8MBlpj7vRTcF?=
 =?us-ascii?Q?7JJSquxk/hevfcqAUXfs45eftcySBpMzifLhZwbD5PX2R4buhS+s3/FkPRQT?=
 =?us-ascii?Q?P3xxIcUCIC1ExJAC58s8yuWzlYX4gHQGlaTZOSltGLryNcEQpJbhuDMGLvqW?=
 =?us-ascii?Q?ylTK6qCWFruvOdzLYynh72UC9O3UsQYR/DKWptE1m5zi95BiqNgfOWr712sC?=
 =?us-ascii?Q?68x2XKSB/L9wR7OS2oUiJREsFelrIMc/+h4LAj2XskUo7FGm7/m8f0/mmwHu?=
 =?us-ascii?Q?neEC9pQ950+yhst6EUU2CZlWbKX75prVO4NUCG5QbZNF/wAri0yKrLUZByKT?=
 =?us-ascii?Q?HLP/2Zu7Tkw1plhfmCK5dld6PWaFb5YBSTqCtD11jDpUbArAyqNtb1RyKT0W?=
 =?us-ascii?Q?cj3Ezo+mgp+2RBY5wqyEsbXr7QzgB/quonDUah33s2LlSDtT4+q5L+t6U3uD?=
 =?us-ascii?Q?3msOBhmzUEFQo/TBPW1xZt/AUzWT4AOy2yuqmJ8L/KLkJGRsLtJE7FLbca0R?=
 =?us-ascii?Q?/1DOaHAsN2AUvEronrYN5pwCpJojcn7m6hckcnlI4ob/C6vM6n3CE4p6Gn1I?=
 =?us-ascii?Q?BxTt11KzGGHTsbXBCuJcdVn1ZK9rIDtui7TVi4wb5SsiYGx4jf18RlXkUmkb?=
 =?us-ascii?Q?1WtNApiaprL5d8UwLisFJgfkZjZ1ZtJXMlAePqMJ7c6PW56Bx+GvJItZ3QXf?=
 =?us-ascii?Q?xoDZlLKwRDlXClYP65VAhCsQsB6LtB5bBcK6/2cxD0vb0qlPeh/mgMMzS90p?=
 =?us-ascii?Q?CGH7IQWDP69AVe6nezFOgrVuq6dYX95yVXM2ZdKWejeExZ9xVVchj7smLVor?=
 =?us-ascii?Q?wvGnbKWZrye+E5355p7WFBZwNlIM7TZPS3FrB4jlFGXCLFsAoz2NQ4ix2Eg8?=
 =?us-ascii?Q?ETbUf6YsuEk6uY75tsW1nYXGgesH7EstwuEqQt5heH+3XR/+PQKTdHEprsJA?=
 =?us-ascii?Q?S8ZLqcGoeMW5qjGWyxyHRHdgdEQ7nG980JeKx8fuIKOps2QQzR07VPz7EKMb?=
 =?us-ascii?Q?zyXO04FJb9RdVFnrHOxhvkdTQgA+qYkX2PSkaZbUZF8ym7mSrpQf7ICTPtSM?=
 =?us-ascii?Q?xKfBf3mhEfMPMFEaE45qDGZmYo7r3wNREVaee/rxrVTvkfByi5IH4HLJr7au?=
 =?us-ascii?Q?+NXm14i49yeuPDyXsOr/a5iL5w1302MdXzsASvb2Khap7clygC6JufErFt3o?=
 =?us-ascii?Q?4yMm7KXKR5Wv9PNs+weTIzC+SUr8/wd+PfIO7K6ZAiC/qxFcgNRcGJRJbW+D?=
 =?us-ascii?Q?IY7I5encxgyt/QM1isRcZ7ACLzwL3hCriv3+BeKRn6UlESMPJ1Au5+3FvJJu?=
 =?us-ascii?Q?llQI4yb0Efkp+aohiuYLhlg/ca74Y9aI7UBp7bzXIQbN4Acjko/yDZByJReK?=
 =?us-ascii?Q?ecc1gCVmfKJCNeRwwM1X2TYNfFuQQYUuO1stJa6+L4pwRaze0rDgkZMCU04a?=
 =?us-ascii?Q?gk/j8AaS1NOKE2XyES1yhASssz0nGdQHAdDez7BsKAYkX3uirGUtA8s08U8K?=
 =?us-ascii?Q?wMWLyVbbKxLX9M5HMZMqpN11S3KnKLh7Cpk58BrI3anPzTnZX9P9DFbTkjhV?=
 =?us-ascii?Q?BXkUl32q+Ee7LduTFTkGBaWViV/BGyPuoAdjkYmuI/yxpLrVLdlr3PY2Iioo?=
 =?us-ascii?Q?jQQFOtYB02/VxUVtWalrQx3+X49pvbRlEQX0M5A/E+xrMhWv/Vmi+jnnhh1y?=
 =?us-ascii?Q?Kgokchtw1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a572a9d3-dfb7-4a48-5679-08df0ba8c8c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 23:52:46.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNrjqmXCe6/HxBOpVZnW2VIXN87x8sumlSd+RxSLbMxUO8BEG1xyK4LGe3qNQwNlcx55E34jS9NvVS0PeklpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844

On Sat, Sep 05, 2026 at 07:32:45PM +0100, Simon Horman wrote:
> On Thu, Sep 03, 2026 at 09:20:36AM -0400, Yury Norov wrote:
> > The function has 3 callers, all except one explicitly require
> > pf != NULL. Add the corresponding check to the remaining caller,
> > and remove it from the ice_pf_state_is_nominal(). It makse the
> > fun function a one-liner.
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
> >  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 73996e3022ef..6d5b8acc4764 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
> >   */
> >  bool ice_pf_state_is_nominal(struct ice_pf *pf)
> >  {
> > -	if (!pf)
> > -		return false;
> > -
> >  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
> >  }
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index d88835482d3a..168d85f9477f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
> >  
> >  	pf = pci_get_drvdata(pdev);
> >  
> > -	if (!ice_pf_state_is_nominal(pf)) {
> > +	if (!pf || !ice_pf_state_is_nominal(pf)) {
> >  		dev_err(dev, "Device is not ready, no need to suspend it\n");
> >  		return -EBUSY;
> >  	}
> 
> Is the new condition necessary in ice_suspend?

IDK. I'm just trying to stay on the safe side. The
ice_pf_state_is_nominal() was safe against pf == NULL,
so I'm trying to preserve the invariant.

If it's impossible, I can do:

        if (WARN_ON(!pf) || !ice_pf_state_is_nominal(pf)) 

This would imply unlikely(), and more verbose than an implied
assumption that pf is never uninitialized.
