Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761923507B
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919568; cv=fail; b=tLNZsNmR34E5KORv4MmT+j+rpNlEUbMksVnv1Z+EqtDEQnmoQ8XxcWYh2rB1+upCACA30Dua9VzMzt5UNw0M9s7n8K8FtnYuTiOAqx3J9L6YQNr6uxIV/VU8sc/8r7aS8/2uCOrwweTmrbCxNvjLd9eAKLKqP+CVWrN4WG44AfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919568; c=relaxed/simple;
	bh=e2hUQfSxpEjWKt3QlVgagjKuic1nPadwwyrmX+1+tnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wf+b1VZjwMkzmpMjSNXS7l89ArvQLvqu2O2QSRaupadBMKJ5xwbvahZiXPgFGzuBon4ZiXeuosjkDZ6BC7L6IzQlmLXMTgE5LmGtfrpVU/5ZX29Yo7R9j5obkv+q20rGo/dcB67gOxRWSjBVnPB86Cu67M6jDHdNdzsagvQUarI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0Usb1/O; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0Usb1/O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u04W8NnNCbj7F+gMopSb83uGRtI5QK4kjp9Z9JVI1ydg+nD5m9NwfeUZI99ta4brnusZvRFL3vKWYUEOAHILZz6JrvmtLamadrjHvOQlKlU3lvTek64xjGh2hZIgtAJ+XD9vJGcaM0kYKvpSYMQHj44KiB5AO24eI7BEv9bUvZexvbfMN4r71zke2FQ3vn6x/YmSsMF49BBT514fjgFWs97oL93vBlhH95+l9l4SqhtzUHnzQOWwRwntsE3E0sGtzQAKo9VDu9yoYKT2LUakRUghSfI2TXUPlQYZwERsoPGWFZw8tg3WfPvg44POSiU9D844hKKcNCk4Yxt6oDsT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb83lXfCjPVq3h/PwPXBbZyFcFGfklDZteSu/eTVwYg=;
 b=TGFhNm7EO26PVIP/uK3xjlDg98WolxV7imGssNRDVCLX/3v/yw1cvrtsVnFhGs2UtHSz5FtXCFpu4lzwZMsdbyLAVfoLmqbrwocd9bvJ7iYmHIYsRUEAgfxN8Oiy+lf6XqPWtaY8FY1Jh+kZa2itCyQIlr+glHvceIKtJxEEloBSgU0vF/GguhcTOTJlSwGxa+VgX1jWmlrvRjnbQf3ZMIgAQADL4dUqWUAGWPU+dn3hAKo2WO1baABv1WPBD8UHvvh2gYqWK742mmQdKdVOtzPdxNhmmFVYPys9suf2TgkbP+ZeKs0mY9i9Zl2cJwTI/SfywSEnPCd+vYejQQvQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb83lXfCjPVq3h/PwPXBbZyFcFGfklDZteSu/eTVwYg=;
 b=M0Usb1/OAlNU4tC4Luctc5A98So2+6y2YMLM9gwspoKA9lrEvVtS4mGedf+8PyRqSePZRzf2OXclBQmS6d1Pjrh2NLtER054/sSOxBdMEVh8oWrfwbyWZf4rT1VZ72Bb2lwYZLjsdTIHMsT9lStf8j569NjMkkiZFQJFTUXZoP8R5zHIaTmmmXR6y00Ky3Aki3uj53cmLc+v6AneTahqesD90HYkI7rIveRbHcptNUv5oD2Ha5k5yCJz2pQmKM1hCpTivWfyy9uohyP+esuowGRdP+ciT5IREfsnrC6ib17wf+BVdclMQ5+m8buN2eZiZSsvRl+mhN8KxFw5v5dRhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 15:52:41 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 15:52:41 +0000
Date: Sun, 20 Sep 2026 18:52:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marc Harvey <marcharvey@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] ipv6: Prevent rt6_insert_exception() for dying
 fib6_info.
Message-ID: <20260920155231.GA2014789@shredder>
References: <20260918082209.2853582-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918082209.2853582-1-kuniyu@google.com>
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a2f9f7-c173-4148-1959-08df172f33ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MktagOxeBeB0Y38SuTcduMOSJ7N8rFYSBPBnm1N/gG3qhjVIk6yVUiJ5dXw/C4wDScADqu9p8PRRL7YQPq9BmNkYkER/jTZ0W6xQVfrbLZN3ScVF+weEaGvir8RoSC9ecH6D9DfUM1+W1amOmbXX4CXPbZZg9YgoXoqlqvfHSmwFAsnG56QMyKtuVwfTdcB1READZOIFbR+UKjRHVd4d0HwFofY/4DnemVmNgu87xhzsSRU28KaGbWgS5pOXlc1hCwZTyBcgyBWtmbNud8nUWDQyZN1wuHQDiIfGgAVicvDZhW5qSRp2rThLkV4AOJXCZ3HID/7idrLkKiuL05O+VjcLU8Wv0Htj4ZoaQC4qhSw9a2u8cYGur4j0mZTCRZqc/f6oszTDFUv2UjD1hRqk6QSaeTCSGZ4PlUL2bPnhyFLA5e0oG6YMPPCx9JHpH5VjIQtFdf1Rf0maqzpk2MbBMkotnICghcL4SPU6MGeYKhsqlAvjGA1eUTf8LO0Wcm2/hh6CIfohYg9PcFWMTw86JMSvKq6/bhHflqzQN1Pos3zd6a4bnobqc/NKVQJx6jap28AN6Jms/hzLQEjQ8KoWE9cOx8sbVx5szeygWn6KOwE+dh04eZxycEHit1nFYwxHkLnEFcauNJkzIfkPgdqOv0dV5vFXUZF+9mosCX3Rk54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yqjtj7sJaSZi+yT0lvRC6TitpgTqBqtooiWJyzuJ9+QZQoTHswLn/bt++idN?=
 =?us-ascii?Q?IytYJk88BNqtg1AvLavs9+BnEmkg7NADQ/MvCaL+Zy/jXUD6niZ5LX69+Dgm?=
 =?us-ascii?Q?3ZW+GQgugo1buR+kXnqbF53wmmri+xQTVoYA92h+jkw8pI4C4yQCfABMxkVg?=
 =?us-ascii?Q?ILCIGdQoBtlG8maBzyc2j+GXt1U+cHpVUPUoQWwg5huFk2/cW1EtgyTVFo5b?=
 =?us-ascii?Q?b6vKKSqdHTnWM2JMkLzVUD9Lg+EOuocjZGnZUEY37FgQKqt5i9eEJIhlXVF7?=
 =?us-ascii?Q?yjqyPHm40zRFpVgXAQ4aolfcJTRPKSJZ9OZ6hm7Yi75PcytJhGPlHjS+uJxE?=
 =?us-ascii?Q?1dsDZKjlEx9Alwba1XATJXFXs72OZdFc6MZpXWdUNP4SM38sTbj1MTBMga5J?=
 =?us-ascii?Q?rgwYjjzjURZSX2rUYm1peyONkkAYUMsGCITAII5p0r3cs/D9DcsWq5ISc6dO?=
 =?us-ascii?Q?O8K2z0qSZKnBTnvbAwh6RItbxVyID5HdAvTBseowU+gHB2V65yLJnPwaMMJY?=
 =?us-ascii?Q?LdouIr0ke9a+PnCwYefGIE4YkPKxLZregK2q9Sfp/lYkJ2ErWKqrjXGH/CyF?=
 =?us-ascii?Q?w/YAf9siq7Ka3RkWLPIN+26oZ8dPWYuJdZrqNBMSyfDf8AIBWcKwYFRSwtvo?=
 =?us-ascii?Q?Kb63obqw4XBsFez+xPtB09D5gMgJO1QfNtrLJeBKvGCeNrknflXS9trJTZ6l?=
 =?us-ascii?Q?EiPshZ7oENNmxsGktAKRfmWt1ofoeSnvjcEKpiKdhWIwUTeif7aD8sMhBSx/?=
 =?us-ascii?Q?BwP6I2PFFZ6z6tJ4lIAzdHixUoaZER3biV/dKE+QXN1UyDb5t+RmsVq6ElTN?=
 =?us-ascii?Q?CKxVf8VdPTeGYwe93blgD6mXi9YvHPRDqH8SXKdFqLtYDZeM61ThLgoEaFAZ?=
 =?us-ascii?Q?FZQiomj/o14GJJXP1jCJXFXO1/4v8xKeDv2A1UHXIf0DpAk4EFiTfdC1H5/q?=
 =?us-ascii?Q?u6q4u2IBGfFNziwumewdtQTBvx8ZWkBHs0bxkJRvd86eGME/pSd/GcPRRUFL?=
 =?us-ascii?Q?R0k+IWSNuqhmaa/2ZJ9Js8rnb+3wsSUM1yrra11bFJlqRvO9BYDW5ES717II?=
 =?us-ascii?Q?OPJNMAun+9T7z6sqRU7+2rWDmVv25/QosTRiGclg6vwqnE1tDorc3cfHGLkq?=
 =?us-ascii?Q?7RWoV/Qyb4ncK8PjdoI8rVePGndzeMCrlMW/VVHAlVineZ7yN6W8hd90hn2d?=
 =?us-ascii?Q?hsp7IvzesNTLekai3tjrqwhgANpIE0dumwl+jHc3EqjcjO5PdUq0XN5k1Q3r?=
 =?us-ascii?Q?E0b4tX60KnrBdEaWsek3cP3RpKXf9UpP2CeP0VeosoQD9Ht616886nO8c7rl?=
 =?us-ascii?Q?XA7fSTCdqZ14CC27JZkHiyqIrS5hwPkmd6FPn6bQT+RyS1f5c2/dRl2JFiTX?=
 =?us-ascii?Q?aTPZke5LX2VzZAKSv1ZA1uT09qBeTuetYvw8QCGV/jDJF2pzGueSZiG1eIvV?=
 =?us-ascii?Q?7IzSt6+HBbbiY6LScRgX2RaXqj/ZIMdYu2nKbbdlJ6USdSVzvri0LlG9R21Z?=
 =?us-ascii?Q?TMF22fzNj8C/mcncbK33ABPjpBQC7sU3pJx3ai+k2D8xhlGtuF5dFiMNGRTb?=
 =?us-ascii?Q?+CY4Bc29ZCHb0OYNFxfyjLq4iY2FLQo+GVAeFVSN3U9RP5Gym+tGTLdwR5Dr?=
 =?us-ascii?Q?jwCG8p+xqv5ISqumzsxygbROXF3h7P/SO4NzSQQDDab7f9xwb6O6FdixBuzf?=
 =?us-ascii?Q?omltiYQtBzgzjTcAlmes//IIMY/Pq/uzENIm/wx//qt3VWtM8B1LeCXbnEb8?=
 =?us-ascii?Q?WWJLS7SwSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a2f9f7-c173-4148-1959-08df172f33ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 15:52:41.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nMgB8WqxXKo2S/aNR6T1X0YSmc5ld4LS1dJKcnmRbuyPp8jyC9YujfFsLGTZHWoKIoGUHYsmNrjMltY1pX+FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

On Fri, Sep 18, 2026 at 08:22:05AM +0000, Kuniyuki Iwashima wrote:
> Before the cited commit, fib6_nh_flush_exceptions() always set
> from->exception_bucket_flushed = 1 under rt6_exception_lock to
> prevent rt6_insert_exception() from inserting a new exception
> for a dying fib6_info.
> 
> The flag was replaced with the FIB6_EXCEPTION_BUCKET_FLUSHED
> bit stored in nh->rt6i_exception_bucket.
> 
> The problem is that now the bit is only set when the bucket
> is not NULL and fib6_nh_flush_exceptions() is called from
> fib6_nh_release() after fib6_ref has already reached zero.
> 
> If rt6_insert_exception() is called while the target fib6_info
> is being removed via fib6_purge_rt(), a new exception could be
> created successfully because rt6_flush_exceptions() no longer
> sets the bit.
> 
> This creates a reference cycle between the fib6_info and the
> exception route, leaking the fib6_info, its nexthop device,
> and all per-CPU routes in fib6_nh->rt6i_pcpu, which stalls netdev
> unregistration.
> 
> [   34.680602] unregister_netdevice: waiting for gre6 to become free. Usage count = 68
> [   44.920675] unregister_netdevice: waiting for gre6 to become free. Usage count = 68
> [   55.176582] unregister_netdevice: waiting for gre6 to become free. Usage count = 68
> 
> Let's call fib6_drop_pcpu_from() before rt6_flush_exceptions(),
> to set fib6_destroying before rt6_exception_lock, and check
> f6i->fib6_destroying in rt6_insert_exception().
> 
> Note that FIB6_EXCEPTION_BUCKET_FLUSHED logic is dead and
> we can clean it up in net-next.
> 
> Fixes: cc5c073a693f ("ipv6: Move exception bucket to fib6_nh")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Looks OK, but if you need another version (or in net-next when you
remove FIB6_EXCEPTION_BUCKET_FLUSHED), then also update the comment in
fib6_drop_pcpu_from() to make it clear that 'fib6_destroying' also
prevents the addition of exception routes and not only per-CPU ones.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
