Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA310409101;
	Mon, 20 Jul 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563685; cv=fail; b=OfW3HwLb2qMYIvIMC2Dy6mxCi2z+z4N0Fw62BHDaEA4eD2+5I7JEfeWSFOd+L2YRfibfT6ZWuwvkt6XsvIbC0DMMoPGSgYFesyO0JHHozRd7Q2z2goIpy4lfhyRhVnvBP1lz5nt0Hum1IYv0suiTCJIDcErWxF9IvCSTU37qwh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563685; c=relaxed/simple;
	bh=M9YeS57Ov2qsksTe2gdLv9Qlx2Pv5Xct75DSukJSpbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KBbV3HnSWL9AAwJqTb0uoICxh8fwtaEAEkLS6QD8UTvHhxMvptRcr/0ZmTP11DOw4cT9dWIdk9pBgPW4yTxneATaY04n6iRj/C96HR87O+N4RAZhwM3XXRu2fzeAdjJ4zA5KtwknBovgpq8goiHoZgw6ckX1IGPn4gaCWzFzINY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBuR0Pem; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBuR0Pem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784563684; x=1816099684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M9YeS57Ov2qsksTe2gdLv9Qlx2Pv5Xct75DSukJSpbk=;
  b=KBuR0PemKZoKc3XiZTKkj3fDLnM0qTDFqbRy7O1yCXPsrjWVha8zPcl5
   7g5yE7ARQHzvPptqCODEcEiY4yVvkzm+M2UFRWW/n13P5cbqR84DZc6Ce
   c43ccORdZUR8ecqWurIduiPTLDq5b86b9JcDpWJaJWPQcAJmmiMkWkf/q
   j3oPvRt3AokyMDP3hLk3N7voEeCWuO1Hsy/v66uvPZu6zGC6yDgypo4yv
   cXXWMysqTGRUn80nJcRdPPr1BI7bsffV40LWvqXmUjUJKwX5S0wjuNpKR
   ClnLOETIy9TcnAr6ykf1mQBs93JZAZehjLhfceOhQFAmVsZGXn/n0JmAF
   A==;
X-CSE-ConnectionGUID: v9fMLkRBS5+kQRT4Hel4bw==
X-CSE-MsgGUID: QrzWQF7LSAWzplVyjT0MWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96283247"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96283247"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:08:03 -0700
X-CSE-ConnectionGUID: YT+ZG6/gSEOcW0c5zkBY8g==
X-CSE-MsgGUID: mUZLkAgZTJ+Owr+IVWlS0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="287553931"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:08:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:08:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:08:01 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGz/PHv3y6tcWbCdW4cy6D6HFOfyomF8FaOic5ejk5GyhMokPdgOeowwt0XDaUlQWerFwTr7EgsdiLml3g6le8FnWunjfNo693vkm9HqY9ao7SGq2F5Vi9FIQtJF1y2g+m24SXBdb6NfqZRdpBGfcnyLueL4B9URSqBMQCDX5EyCHIoCGmscvZy4W2PZycj286Ku3KikUxVsaeJijAHzGlRgbj4qIUWnsRs8zy24Bo5FmTmIi1B8bedtXgeuJD+vPxnAe97TTPC77xyMscx/FU2YCMX2/8EGDFxjmuPcwwebefD2XEcA2Eb33zqqQm9lI/Bxjn/hdOQD2/po148zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0m6Md+1RGhyTzYJNf3qXvtv5WWGwZSWPktAKWyUSkE=;
 b=rdlFjK1YtO7EcKXHQAHaf6AkSUtEhZMJYubXc2n7vdBN4eYl5hNvebrCs2a33AAtc4Y+7FUz9O3Chvhu3GGZyyah4i94sOIEfvG9AMJa9ThByc1SXePT+atRevfXK3ZYvruWlobA4c7dVizoI6v6nJ/tYBTk5omR5GztvLM+8zkqjTQ5xKG7Q5w4PeQBuSSRlQcsCtnj6HjOwbskzTw72JwrF9yORfHsfpzeD/Mf5y/7rEcyJuBUD7iMrKzlTLvWN3FReTpyi3N7ln+FgyC49Fk5x2tjuRn/yQyr9BZeo/y5taso+tdipXzLsji5grYuwHxEpYhUW48hgaPaMP8T/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:07:58 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 16:07:57 +0000
Date: Mon, 20 Jul 2026 18:07:48 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Phani R Burra <phani.r.burra@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>, Bharath R <bharath.r@intel.com>, Samuel Salin
	<Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v5 05/15] libie: add bookkeeping support for
 control queue messages
Message-ID: <al5H1GWW_lUgPcTN@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <20260715180042.1972010-6-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715180042.1972010-6-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: ca59f7f2-ddbb-47d9-8aca-08dee679105e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|10070799003|376014|7416014|6133799003|56012099006|5023799004|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6tON4mmOjbYYicgM00jvSwXwiz+ZIFFkDJmZ8vCzqg03IiUPFTHVdVf6ByymqNqa3bIINjEUkV/4KqFAkhYecHBbXz+8YmoT0xDXDDiCXjIXlN0mVi3GevDqnbiPf33pyk011aSM/thUtyBjWQpccq2gvTOWpiXkui3mGyErEo3Kw3VCVA6oVVPD37AeeOrEB4W5MUkkVt8ZlS/JJ0WVF1++6ed0UHJ6pQEKWRJTQqwDf1rIgoq4M90LGPU3Sc4SXqq9TGsat5e+cu/fjLYb+W0BNkXPmt7JA2JKFh0N8HDQUnygOfqJ4UEtLLF6K618CAQAuaws9VKY0gkDENxBSY2dwAZ6w0R0V4WG/RVGeZp6uvncBJZ7D1kmES671ACz7LsFRXFkSpY+kyaKMECTtPsiCPs2quzi0qw2JJKYEzQYcQI/zXayyLf0f/0cR72neoG902qGejbW2IPGjYQzuOHFVhxsf8i5jgPB8znRooM31VsUH31vws/z3YHHQ6SDRa4QCAJ+PqALB/On4byT2SMvJyGCW/5pEVcAw9bHiuY5F85UVhSxbkKBCZBT+ecuXO+ZJ6cC0OGLFU1h5Wgj5Ps5A6wq5o1YOwrLARCWhKad39od1buKPpjFCNPkvaDC2gh0rWCIPpudqqCl4BlGO8G0GG236bY2OtuF+IqxhEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(7416014)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JcFqkEV8L9sX6a65dAiTmDQ9P5yrylYgXDBb/hectFZUyUuNL58LbItFE3BA?=
 =?us-ascii?Q?HSvlD6Dg3XRErNwmxSnY4zKXrc0xrEND5+MHarAOcDI/nfav7fnl8Ks8swOp?=
 =?us-ascii?Q?7QJBZj5EM0EpjHoIOFafyDW0C5ldsitVRNdnFbMNhJe0/xCL8IaKIHFd34TJ?=
 =?us-ascii?Q?UOqquo1deZSzO5wdvczVdFLTwh3hCJUE3Uyc5hvxvSS8bFrhPuCw630kYc9a?=
 =?us-ascii?Q?5GdzRtGUQSTI0liIetU2fzgBMLopCsH9hqyRv3Di3FwJspE2lKuH121jmX44?=
 =?us-ascii?Q?wNapHdIHMYSbBgodnbOWiZ+WrgrwPzBg0fHIiFJ8xqnCb4d1lqMsTeUMuj/i?=
 =?us-ascii?Q?3YJdcja+aELa/+chPA3hNhw3JAKG9IjhDRwf9ZJavEweMXQEob+Fps9u+syr?=
 =?us-ascii?Q?+3I8G0jB/kihPa6cWu29rmCDONr+zCu77K6+p5IHotlynJBTvPtsatAI1H3W?=
 =?us-ascii?Q?inWi7JxnQX3BHgBOXd4LwCAmeXun+Ibpwv1VckHmUUrGozk+SLDeNA1YRisS?=
 =?us-ascii?Q?dI+Cpy8quv4vRSqPu98oyEusBe1eXPHhLNSwATr7CXWkvtJYDKDQ+Ed8dqAH?=
 =?us-ascii?Q?e3WSkrqOTtJnSOFh2ApuILLwyky0tZNpBJGIT084WqF4n5WuY13OxKdStAGd?=
 =?us-ascii?Q?AZC/Yz3NnADIhzDNK+ejPXkWmWCM5CBr5+X1/mXdBZc9wW0jyNxE+iMXWwEz?=
 =?us-ascii?Q?bDJeqkNOEJqibeDwWICNBKi+vHd3eaC82+grOpf0trRqOjf5L4ppOQZ83Uzr?=
 =?us-ascii?Q?V/VkUMKMWzVGJlb9ttpfGEKQp1woAPhcHmB/jJpOvNCITjn81RBRtJLjBLlW?=
 =?us-ascii?Q?H8Q0hlPiRGLRkhN6rYOETO6dxsGltstmSUh8mcSJpMZjcnW9ii5A0NsapBNH?=
 =?us-ascii?Q?p6b6gA391uhDTxTMF6kIy91gqLKW9q0jApIJ7eEyB6LnED4wc2MJgpxxb+UF?=
 =?us-ascii?Q?2j/D2zuqj2QpKmSGo9aCSdtUmYU03DetRfGJNH92G9hiBpGBZOzuXxZXHWVb?=
 =?us-ascii?Q?hN6EcaZ3BW5micNFAFqDdrPGdiXrqAtb9iLtbfhY/KZdceLExucbcfYl7YmL?=
 =?us-ascii?Q?+dxt6BqXZpmKoZfEJ5zELUEZjXBgGGRpwtHH1JcWOg3rt8mrGAa+CdBX8IEq?=
 =?us-ascii?Q?nusfg4sTqDaoIOY0sqNZdjHur8+I91yZ10eVkIUnZ9Amw+1JzrD1Gnrq0oYd?=
 =?us-ascii?Q?kDKpYs/4PmpHN5MM2znxPofWjlZzZSYxuE/8C0m9oA+vMSh5SYn63KKMxpdA?=
 =?us-ascii?Q?0oTf4rTPTMGWaWiv94djdQxZsbJhHrwf2868GMyod1TD5qrZMHne8XsbIYUU?=
 =?us-ascii?Q?rUGJE1SmAvNXZS019csGTechwnb2Rsv6NQSn8psBpPsp9s75AUU43AUe7mgg?=
 =?us-ascii?Q?Pnn7lYTcnmQL5FMFy+ZOkCyQDwRyCgZCWhs75JxEs2/pKFLYzN5+yJcg91mU?=
 =?us-ascii?Q?lG3QXdEWFqoSiLXJca3mMca1+qzJKWZKEZJqy8s2A4DtWAYiHtL9PiCkd6HJ?=
 =?us-ascii?Q?G5oLltaaV+KZyDQq4N6F8wSeJxiBf/4KA1+ZRRX+ws20bQRIgI5Uzy+z0clk?=
 =?us-ascii?Q?mEQXKj0xmGrqSqN/WM3NnDWbdiWcw6ndOXTN795EoE4J6PKCD8dwaRWRc9jC?=
 =?us-ascii?Q?UdQ+czsWrt5Z92y3dEa5Je//qe54NN+YzJ3ZhT3vtu0la89rkhu4p2QHZ2n3?=
 =?us-ascii?Q?JU5fCMhMUJazuFNp+/qfO0c2W3Ck1uqWxgqZGcZfO++iN2BLaOaL4UN9ZqqD?=
 =?us-ascii?Q?uVps+KrlrUZE1wmtiB8sJlPGz4vT7MjlYHh8cY3m9/mDBCzTOR0Qn8NCgyWJ?=
X-MS-Exchange-AntiSpam-MessageData-1: ihwyZIWpnQ6b7kcTu9h9bsoZJnQcXO3+g7Y=
X-Exchange-RoutingPolicyChecked: OVOAhIGpF3oFSuisSXEbpLPJvwrEOvJUfgCKWt9EM1byrKr9OVsEW1mVGecvetwR5gzaBDIWJq8OXTtpqd9vygtZoAJ5aybSFMHWibr9Wz1c91/GCHE5i3LcycIHECkQbhSPAYUZMuQM8GlZ00NBeoVXRguBOxKZMs1dYX6frm21OJfJWXmeHQDhQPpZmr/AuKYqS1efIMxmlpUw4t9b6Q5f74GfSiVBqOmFxvwsv+0ynwP2jcOUVtAxopy/EssmrIsaUz7SmowT4f8pcwCrNvF11m9kOgzIeBt76tNQLQqZqfDi0k9aQQRIHCt/7dhkZ+sw8/mdppIQkc0wT7RAQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca59f7f2-ddbb-47d9-8aca-08dee679105e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:07:57.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNa0WdlmAam4cra/ZIaKVWH0JkY12tY7ahLIhYG8xYR3AdQJKSso2M6WB/L+9vclT442k/dqEYszx8etiqBi0V5f1HJbsnVDP/juDDUH62I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com

Sashiko says:
> > +	wait_for_completion_timeout(&xn->cmd_completion_event,
> > +				    msecs_to_jiffies(params->timeout_ms));
> > +
> > +	spin_lock(&xn->xn_lock);
> > +	switch (xn->state) {
> > +	case LIBIE_CTLQ_XN_WAITING:
> > +		ret = -ETIMEDOUT;
> > +		break;
> > +	case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
> > +		params->recv_mem = xn->recv_mem;
> > +		break;
> > +	default:
> > +		ret = -EBADMSG;
> > +		break;
> > +	}
> > +
> > +	/* Free the receive buffer in case of failure. On timeout, receive
> > +	 * buffer is not allocated.
> > +	 */
> > +	if (ret && ret != -ETIMEDOUT)
> > +		libie_ctlq_release_rx_buf(&xn->recv_mem);
> Can this cause a double free on a stale receive buffer if the transaction was
> aborted? When a transaction is returned to the free pool, xn->recv_mem is not
> cleared. If it is reallocated and enters the WAITING state, it still contains
> the recv_mem pointer from its last successful use. If libie_ctlq_xn_shutdown()
> aborts this transaction, its state changes to SHUTDOWN. This switch falls through
> to the default case setting ret = -EBADMSG, and this cleanup logic will call
> libie_ctlq_release_rx_buf() on the stale recv_mem pointer.

LIBIE_CTLQ_XN_WAITING can only occur in the previous critical sections,
since it's only applicable to idle transactions.

[...]

> 
> > +	wait_for_completion_timeout(&xn->cmd_completion_event,
> > +				    msecs_to_jiffies(params->timeout_ms));
> params->timeout_ms is declared u64 in struct libie_ctlq_xn_send_params
> (and stored to xn->timeout_ms which is also u64), but msecs_to_jiffies()
> takes const unsigned int. On 64-bit builds, values above UINT_MAX get
> silently truncated to 32 bits before conversion, and the MAX_JIFFY_OFFSET
> clamp inside _msecs_to_jiffies() only fires against a value that already
> fits in int, so it can't rescue the truncation.
> The async path uses ktime_ms_delta against a u64 correctly, so the sync
> and async paths would disagree for the same input.
> Should timeout_ms be u32 in both structures (matching msecs_to_jiffies()),
> or should the value be clamped before conversion here?
> 
> > +		if (!libie_cp_can_send_onstack(msg->data_len)) {
> > +			libie_cp_unmap_dma_mem(dev, &msg->send_mem);
> > +			params->rel_tx_buf(msg->send_mem.va);

> [Medium, Medium]
> Two questions about locking context here.
> First, params->rel_tx_buf() is being called while ctlq->lock (a plain
> spin_lock) is held. In libie_ctlq_xn_send() the same callback is invoked
> at the free_buf label with no locks held, so the two libie call sites
> impose different atomic-context constraints on the same driver-supplied
> callback. Should rel_tx_buf either be moved outside the critical section
> or explicitly documented as required to be non-sleeping?

I see no reason to do this currently

> Second, xnm->free_xns_bm_lock, xn->xn_lock, and ctlq->lock are all
> acquired with plain spin_lock() throughout the new code. If a future
> consumer drives libie_ctlq_xn_recv() from softirq (NAPI-like, which the
> budget parameter and page_pool usage suggest) while libie_ctlq_xn_send()
> runs from process context on the same CPU, wouldn't the softirq deadlock
> against the process-context lock holder? Would spin_lock_bh() variants,
> or an explicit documented callable-context contract, be preferable?

No softirqs

[...]

> 
> > +/**
> > + * libie_ctlq_xn_deinit - deallocate and free the transaction manager resources
> > + * @xnm: pointer to the transaction manager
> > + * @ctx: controlq context structure
> > + *
> > + * All Rx processing must be stopped beforehand.
> > + */
> > +void libie_ctlq_xn_deinit(struct libie_ctlq_xn_manager *xnm,
> > +			  struct libie_ctlq_ctx *ctx)
> > +{
> > +	libie_ctlq_xn_shutdown(xnm);
> > +	libie_ctlq_xn_deinit_dma(&ctx->mmio_info.pdev->dev, xnm,
> > +				 LIBIE_CTLQ_MAX_XN_ENTRIES);
> > +	kfree(xnm);
> > +	libie_ctlq_deinit(ctx);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_deinit, "LIBIE_CP");
> [High, Medium]
> Two concerns about this deinit path.
> First, do large in-flight sends leak DMA mappings and TX buffers?
> libie_ctlq_xn_shutdown() only manages xn slot state and does not touch
> the TX descriptor ring. libie_ctlq_xn_deinit_dma() only walks
> xn->dma_mem (the copybreak buffers), not ctlq_msg->send_mem for larger
> sends. libie_ctlq_deinit() eventually reaches libie_ctlq_free_tx_msgs()
> which does only kfree(ctlq->tx_msg[i]).
> Nothing on this path calls libie_cp_unmap_dma_mem() on msg->send_mem or
> invokes rel_tx_buf() for a msg->send_mem.va that a caller supplied via
> kmalloc. Wouldn't every posted-but-not-yet-completion-cleaned large send
> leak its DMA mapping and buffer? The kerneldoc only requires "All Rx
> processing must be stopped beforehand" and doesn't warn that
> libie_ctlq_xn_send_clean(force=true) must be called first.

Could be phrased better, but idpf and ixd use the API correctly, so no 
real consequences.
