Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B1390981;
	Tue,  6 Oct 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269822; cv=fail; b=aAXcaFQvpAmpszk2xSK4WSQeQtPL8uMQZ12epF5HagqcvNFloRfF6E/Gt9Mv3ZG9wOamXYDeRi/aO4VoMmPZUL3jWmFBSzbL13Ksh7m9N89pKQOywf3j4O4azBkq73rkrEII5yiFjlHuph46Sg4qLsqEU1n3RL/hKeQ9W4LgIlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269822; c=relaxed/simple;
	bh=GHd0aaez5N5840PR+WBWAkTSxPaissuqe9ONv+TTwRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OD+++2QQnhBXU6xCeDawf/zBiwJ2ysAlUHQIRsa9+d6RzcZiD4v6W8aQniZkk1ym+EjVIiCI4yU35TU3IpmuQlKPVoMBYZc7YzAdchIM3yjfGWSeYhtmwS/PQ3ATRw6zvb7eTfMXCLyMaSK/meM44UEOD0N+gxh2450lR8Xa2yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yCjGiAcu; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yCjGiAcu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkpbjUz4tCQcJT6ABZ6l5caTY55T70SlW9zvqPjiH1hKLcZ7dorsKaYDO7IOovyfvARUr1xX51P2k1YqUO1Wm5mxrIkbP6KYGa9t3HAulE4fwcZkkppx2QYQICwH10Z3gmzBMObiGaaUZMOV2vnKmcYv7OErJauvUyXpccYkF8dxbqB1A0e+PTZ6zf7Ojw2S/azX+REeNKkVWfI+tOSFX0TAtS0uEDaqjD0/gl6uiWK3mHrZTJL2W7JC4uHQRQvG7DPzaE29HowZj1ddEhwEojVNVZLFpeoRsASnXGLQR+IE0dh74DbdJuwVOTxY2y4yZd7w+HcusfxZhXcaMU6D9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnLdbYlKvqXeoSVRc+dWln6FKCr6XWwv+SKfxMf9bjM=;
 b=CPgPdw52THSNUF/NC9GpqYCgFihLfe51VtoL52wyBJCl1Kk5uiVJETE73DgJDVm/m1FFZ3we7WS/OOfblf3e4ebgJkEgpNg6ze7soUcaTf0Sg1SOSHo5FvyhqrHsu5zEUB8+PsqbiE48wuxs3WpqyBQz19z1GlkDROgs1hqJg3VimKiuVb9ZjnnXwYWo4rgiaCKapqpZN3I3oErKBIY2xIJaVQxlxmhVZigCvZqYJAqWW9S6hIGkt70dgTd2mUnZ7yqfHKOv4Qce7gTiZUyA/v6LWvGZ5eQSmGkvluVpIw7B9p25vl1UfUStqn/l8Iby2PCI0qWwku5AsXKqyZ3mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnLdbYlKvqXeoSVRc+dWln6FKCr6XWwv+SKfxMf9bjM=;
 b=yCjGiAcuFFnvAqBHRh6mg0yIAorN4NuDRS4KdMUxid/XDccz0/nmLlC0FCoxTU9e7hHhYLhWNOClv1tQjVVXoXP4UvszvjflTdNAFdZDWcCPYNw/RmoVFSH+GsuYFPKXtjxmc2W4i2Uw0A1LFSe4ikXJgUCUKQVSYbLp29D9YDg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 6 Oct
 2026 06:56:53 +0000
Received: from CYYPR12MB8962.namprd12.prod.outlook.com
 ([fe80::2c04:6d3d:3291:a265]) by CYYPR12MB8962.namprd12.prod.outlook.com
 ([fe80::2c04:6d3d:3291:a265%6]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 06:56:53 +0000
Message-ID: <9606582d-da34-42d7-b08b-32e1ccdb1323@amd.com>
Date: Tue, 6 Oct 2026 12:26:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: phy: xilinx-gmii2rgmii: Restore PHY driver
 on remove
To: netdev-bot+sashiko@kernel.org, vineeth.karumanchi@amd.com
Cc: git@amd.com, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, f.fainelli@gmail.com, harini.katakam@amd.com,
 appanad@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261001074718.3944521-3-vineeth.karumanchi@amd.com>
 <179118764380.434549.2031845358588611322@kernel.org>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <179118764380.434549.2031845358588611322@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::13) To CYYPR12MB8962.namprd12.prod.outlook.com
 (2603:10b6:930:c4::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8962:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: a24ab7e6-c1d7-4c35-3798-08df2377009b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|10067099003|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	9uvWc0BQ6UMBpvby8SCKWwYiDAUyxInRAnL/cY1CM3T8fr69oR46aDy1OwLVK9dDHAgkd/YKxOBnCDGVNyjcvdAaLn4R5oYL38VQAOZqIgscqXJaYJVaiXopBq0/rUISI8lzWcWMV2gtWp0g/eChopNxiqdjDE3Zh5okqMsu0rnEF3nFuxX2pxcRoiXWuanKBOqpc79WqNAiceC2/u8jupSV7A2Q9iiLNjArd4gq7N/tKWXUyFxMoiWaOcLSEkTG2V/WjzLSir2FF4flemDGVsfHX6pCDzTOW4hFGdJIhTrqzvFV/jx8REpnrfiPd705BlPhaYqD8T47mv4hK8ohd+YxvWWTOtAbNWMlSBS89m/gZwfBkxa4wY8SrdNyI7tAXhr5k1YsJYiWP64ChSGn8hm+TgOdxwJfO+/XI/B9H7Mlvq/BRyn6fhdXPo/U8wl9VURB+LBTiBriLjjDGn3J4pcbTqfDRrXoSU6OJo20En0mEtDJzEU40J+9bBnUICnoQkFleNDUWOpdRJbw6+CjYf2WRPI9gcSpTtcSqbAqKHYilfvAGqxccAwxe01VRXTWbUSoz1hukuNkXvW9o9J+7WbjTdQxwrpGTHf3ZqarYPtBg+q0qWJRKy/1hewYQc4X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8962.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUh5NFRkbWJYWGhIaklVd1VWWnlrQTcySi9YYWtlQU1NNVlJcnFJZjRtd01m?=
 =?utf-8?B?VEtqc0hUdThaZVhpODhpS2s4bzhGUUpvckY3NkNiZS9Rd0MweU9RUytPbDhq?=
 =?utf-8?B?SHVLMmpCR2pSeFozdkkzNXNodHJPZU5uVDFNNjN5dVh1NDBabjM3K3hFcVNG?=
 =?utf-8?B?WHlXTUNrK0hReDZ5NURIZXZVTm1DWXBIM0J6UFNsMnFORldETyt0bnd5bjIw?=
 =?utf-8?B?RTQyUVNuZkxrZm5BK3k3RXl1VFhiSDRXVmp2Z2RHNlNNOWJnSURuSnF2MXBV?=
 =?utf-8?B?ZThLOFdXZHdWYWczem1CaXd3aEszbUUydmFacFNkaWhXcHNCcStGaGlmMFds?=
 =?utf-8?B?Y3ZjU3dGbU8xdndkazZ3QXJXMDN2R1MzUExLelJOTERZcjFtaEU1b3FQTXZ5?=
 =?utf-8?B?K2pZSnNHVzByN000M1ZsaWFjSWNGRWxrb293cmg4VnlzdnAwbmFlOU03ZlhF?=
 =?utf-8?B?OHBOQkg1YTlKVGlHRTNOZ0E1d3ZlZEUrQk5jMDJkd3Z1eFJ6cnlOL0RQdVBB?=
 =?utf-8?B?MEJaK000VXllaDVqWSthTUJOQ2xtL0F6TFN3Z2hyQVp3Rm1PNU4xNTlBZjhO?=
 =?utf-8?B?alVQK1ZUanFaNG91ampXdFpNeVVYUUZXQ21tUC9idlUySUJ0cE1kSFc1Z080?=
 =?utf-8?B?WklJUUl6WDJSNGdZeXpUQ2cvYU9KVkcwangzZUEzdzBQQjU1b05QK2pUNnBK?=
 =?utf-8?B?V2FjYzFFR2E3bCtQRzBUN2FCdmp3NTN2VkRWZ1ozbTFQWGtFQlE0TEw3NGds?=
 =?utf-8?B?ZFZVZ2dsSmlXbXh1S2p0bERtRjA1MEtEVUZxMjJmY0d1YmtBYjRzRXZOUkh1?=
 =?utf-8?B?RHdEL0hvTmdUQlQ0NnArVEJzR3NCWTh5bkVUUkU2U1ZHaDJHcmtuRXR3cmtL?=
 =?utf-8?B?OFBZMHd4TlVUUUxtRWhiN2wwMHp0bWZvVGdta3dQamJaQ0RPY012Wk9heHYy?=
 =?utf-8?B?dVd2bTk5Um9JUzlZbnRhUEV5N29PaXpDdHYraENZcU5CbVdxUXMvWjBoUFRu?=
 =?utf-8?B?Zi9tSjIxNDNFRUxFTzFWUDlzV2VPL0xCQVp3c0xucDhISkE1bVJsNktwRXR0?=
 =?utf-8?B?cndXUUhLVWVKZThBR2dkZHg5ZVFZbmdzMGtFSHBpc3lyNmVjNmJ0ZlJPV3dl?=
 =?utf-8?B?ZjkrT05wS0F4ZUZrdjVxOFg0NDlaT0JzS3h5QnlFUW9MRW9tQS9UTmg2a2gr?=
 =?utf-8?B?QmV0dC9XSktiWUlXYTlwNExxeUY4MmNVYmRudG1oTVpCbndwVzNxRGowSVVk?=
 =?utf-8?B?RmYrK1ZyVnpQUWYyWEpIVzRiaU1GQStaaTZ6LzNPWmVscW9aRlkya0Ivc0c5?=
 =?utf-8?B?c3BmZXRJcm80WW9FTDNRVXAySGRGYThJb0dIWmgrM0hsZkJKVFdmT1Q3Y1Y1?=
 =?utf-8?B?ai9xYTlPcnpvUmE5WVcrT21zVlg1eTBrRmFEaXdkTC9Za0hXQmZnelBoeEZ0?=
 =?utf-8?B?NkkrZmZVenpvckRaWjJDUUJZZk9tMitVZmcxRSs4YkJOQUE5NHF4M3BZek9m?=
 =?utf-8?B?VXQrQmNKZnZOVDUxNW9tNVc1SFlBY2hqeTZKL2RVcHI1U1JXYzJlQXc1bTd2?=
 =?utf-8?B?bVgwby9mcG1ncnFtZms1R0EvdjNXdzB5bHF1TlE4dHJMZEd1Y2N3SVZzWTZh?=
 =?utf-8?B?OVBCcURJakhxOHI2K2sxSDVLb0xqdFBCTDgrZFRPSCtaQTlLS3ZyN2JXSmRT?=
 =?utf-8?B?b0Q2bElsbFR3dGpZa2J5MXA4SkxOeDlrMWdOY3BQMDI1WGpOdHFaZzFMV2pV?=
 =?utf-8?B?Rkt4Y2pBc3lxYXloTlE4Tkp0NnE3OXI3R2U3WUJoUG5WQnhYTmxFMjNUNHpw?=
 =?utf-8?B?VVZLVmpYdnJEYW8rMi9PYWxXWEhCMW03NE9nNm9CZFdQL1lxV1ZYQTd1RUJj?=
 =?utf-8?B?NlV0Zlp1LzF6bVdVQ3RiSmtCQURHV1ducFoxanBaTVpSamk1Zm5RdDNFYWFt?=
 =?utf-8?B?NGN5eHRrU0lsNWhFOVNhUWtxZElkTHNCRmtPZzFKeEUxNURLbWZadEdrNE0w?=
 =?utf-8?B?ZHpjQ3ZGT0N4VlBLczVtMmg0bmcyUFE2emJOc3pnVHhjY0x6dWxiYlU5SmE0?=
 =?utf-8?B?emN1YWdzMGRqOHdkMFVDcVFRTmhYVkZBcVhIVmlSZzlRRmFFV3VsWTIyOXF3?=
 =?utf-8?B?RzMzYy9KZkxESm1uV05JK2s0MjB6ZVU0OFJLamg5RlZhV3lENVdUTEIvMVNz?=
 =?utf-8?B?ZUhmK3FEYUp0R3dsNWNXbGpvVDRkQ0ZISTROTFU5SUNReGNwNWs5eEhSbmpF?=
 =?utf-8?B?NUZyWWoySkVOWWFObzhlZGh3OW1jL0IvY01QaHdHNG84N1VjcTVhMEFpNTIv?=
 =?utf-8?B?and1TnJTL0tZaldqNUZDSkZTak9DWlNVcU5JMXgvN3lQRzl4SXhJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ab7e6-c1d7-4c35-3798-08df2377009b
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 06:56:52.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQvSKRIfS1G0sTmD9w8TEt+t8/2bEYOVUvq73ZIDZgAQixcK2OVL0yuh7+ORDhdb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

Replying to Sashiko :
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001074718.3944521-1-vineeth.karumanchi%40amd.com

On 10/5/2026 1:37 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] xgmiitorgmii_remove()
>   (drivers/net/phy/xilinx_gmii2rgmii.c:147-149) always writes the driver…
> - [High] The fix relies on every reader of phydev->drv holding
>   phydev->lock, and that is not true.
> 
> --
> 
> net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove
> 
> This adds a remove callback to the GMII-to-RGMII converter. The callback
> restores the attached PHY's original phydev->drv under phydev->lock, so
> phydev->drv no longer points at the devres-freed conv_phy_drv copy after
> the converter is unbound. It also drops the device reference taken by
> of_phy_find_device().
> 
>> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
>> index 61f71e977a574..b9aa5515577b5 100644
>> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
>> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
>> @@ -128,10 +128,29 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
> 
> [ ... ]
> 
>> +static void xgmiitorgmii_remove(struct mdio_device *mdiodev)
>> +{
>> +	struct gmii2rgmii *priv = mdiodev_get_drvdata(mdiodev);
>> +
>> +	/*
>> +	 * The attached PHY is a separate, still-bound device whose state
>> +	 * machine keeps running and dispatches ->read_status / ->set_loopback
>> +	 * under phydev->lock. Restore its original driver under that lock so
>> +	 * the swap cannot race an in-flight dispatch; the restored driver is
>> +	 * the PHY's own static phy_driver, not the devres-freed conv_phy_drv.
>> +	 */
>> +	mutex_lock(&priv->phy_dev->lock);
>> +	priv->phy_dev->drv = priv->phy_drv;
> 
> [Severity: High]
> Is it safe to write priv->phy_drv back here without first checking that
> phydev->drv still points at &priv->conv_phy_drv?
> 
> The only thing the converter holds is the device reference from
> of_phy_find_device(). There is no device link and no module reference on
> the PHY driver. That means the PHY can be unbound or rebound while the
> converter stays bound, and in that case phylib has already changed
> phydev->drv:
> 
> drivers/net/phy/phy_device.c:phy_remove() {
>     ...
> 	phydev->drv = NULL;
> 
> 	return 0;
> }
> 
> A rebind does the same thing: phy_probe() installs a new driver with
> phydev->drv = phydrv.
> 
> If the converter is unbound after that, xgmiitorgmii_remove() writes back
> the stale pointer that xgmiitorgmii_probe() saved. Three outcomes look
> possible.
> 
> First, an unbound PHY gets a non-NULL drv again. That passes the
> "if (!phydev->drv)" guards in phy.c and phy_device.c. The old driver's
> callbacks then run against a phydev->priv that devres already freed. If
> the PHY driver module was unloaded, they run in freed module text.
> 
> Second, if the PHY was rebound to another driver (for example Generic
> PHY), the old driver's ops get installed over the new binding. They then
> see the new driver's phydev->priv.
> 
> Third, if the converter is probed again, it passes the
> !priv->phy_dev->drv check in xgmiitorgmii_probe() and memcpy()s from the
> stale driver struct.
> 
> The comment above assumes the PHY is still bound and that the restored
> driver is the PHY's own phy_driver. Nothing seems to enforce either
> assumption.
> 
> Would it be better to restore only when phydev->drv == &priv->conv_phy_drv,
> and to tie the converter's lifetime to the PHY binding?

OK thanks, I will update in v2.

> 
>> +	mutex_unlock(&priv->phy_dev->lock);
> 
> [Severity: High]
> Does taking phydev->lock here actually prevent the use-after-free on
> conv_phy_drv? The commit message says:
> 
>     Restore the attached PHY's original driver while
>     holding phydev->lock so that the update cannot race with an active PHY
>     callback.
> 
> The lock only excludes readers that also hold phydev->lock, and not every
> reader of phydev->drv does. Once xgmiitorgmii_remove() returns,
> devres_release_all() frees priv, and conv_phy_drv along with it.
> 
> The state machine drops the lock before its suspend step:
> 
> drivers/net/phy/phy.c:phy_state_machine() {
>     ...
> 	mutex_lock(&phydev->lock);
> 	state_work = _phy_state_machine(phydev);
> 	mutex_unlock(&phydev->lock);
> 
> 	_phy_state_machine_post_work(phydev, state_work);
> }
> 
> phy_stop() does the same. _phy_state_machine_post_work() then calls
> phy_suspend(), which copies phydev->drv into a local and dereferences it
> with no lock held:
> 
> drivers/net/phy/phy_device.c:phy_suspend() {
>     ...
> 	const struct phy_driver *phydrv = phydev->drv;
>     ...
> 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
> 		return -EBUSY;
> 
> 	if (!phydrv->suspend)
> 		return 0;
> 
> 	ret = phydrv->suspend(phydev);
>     ...
> }
> 
> phy_ethtool_get_sset_count() also dereferences the driver before it takes
> the mutex. It is reachable from the ethtool ioctl through
> ethtool_get_phy_stats_phydev():
> 
> drivers/net/phy/phy.c:phy_ethtool_get_sset_count() {
>     ...
> 	if (phydev->drv->get_sset_count &&
> 	    phydev->drv->get_strings &&
> 	    phydev->drv->get_stats) {
> 		mutex_lock(&phydev->lock);
>     ...
> }
> 
> Could this sequence happen?
> 
> CPU0                                  CPU1
> phy_suspend()
>   phydrv = &priv->conv_phy_drv
>                                       xgmiitorgmii_remove()
>                                         mutex_lock(&phydev->lock)
>                                         phydev->drv = priv->phy_drv
>                                         mutex_unlock(&phydev->lock)
>                                       devres_release_all()
>                                         kfree(priv)
>   phydrv->flags / phydrv->suspend
> 
> If so, CPU0 would read freed memory and might call through it. That is the
> same kind of use-after-free this patch is meant to fix.
> 

I agree that phydev->lock does not cover all readers of phydev->drv, so
the concurrent removal race you described remains possible.

The GMII2RGMII driver is unusual in that it substitutes a copied driver
for a separate, still-bound PHY. Given that this behavior is specific to
this converter, I would prefer to avoid introducing phylib changes
solely to address its teardown.


Thanks,
-- 
🙏 Vineeth


pw-bot: cr
