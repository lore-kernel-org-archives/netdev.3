Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023086.outbound.protection.outlook.com [40.93.201.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0F2BD587
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502952; cv=fail; b=gZ50HZMeO1q3uGb/QXWM5uX6Qx1oK7y62RFAhB+ZCllbX5RPvyGXawV1AX9fq/P8qzwJqr6dgFTV8yoaHqyq2nerFiVlJzypNP80B1q+eluXeuOlKRMXX1lIDAzshWvbfORhH/uMQNTr8RS1tQhqjdBIhuoWBhTodHg9OdJ24Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502952; c=relaxed/simple;
	bh=TMrZkMqEX/+u07AYrn98LoA4q7CrDlbHuJ+fnwrcKeA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TLvWLQRzZRVIZBlRXrgR8pzvq3YPrnTi0VlLD1g13Nods35Wggsvoaho/ERE8uzUpUQKS0fRdgsbkvyylub2VUVpdfZpmN4uH4ZL83Xug+iEKS92oq25qqG3Yo0k3ce7anX4VzOhpG05KVeJDBexidC0YZ2qNTdc6czJbDg2GP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=GRcxmzEz; arc=fail smtp.client-ip=40.93.201.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="GRcxmzEz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR9ogzFcQ1hHoUmHI+4S0pcJLN9YJ3reapoJqOKURCohAMxsXjsEWWjELU556pPaA6Us1P+PoxB0G7ACa7+h2gIXb1m1WPbKl8YemQCmC5SoDwm+7RhAsqU8I04kRJpx7s5z+fsedkOQ8seENqvSnSU5ePSH1Xg3otEBK+shYyV4GinX2WfhQy+BV2cXqk87MjSwFpcSYzhKQffQAmSNcQpdhSKg+JB0hSQOJTJ+XPCA7bQN5Ktc1y0G0NSdQ/uq/1l+WhHMFEHBR1P1bx8kYaWQy2RFkhaZZK0I1D3oXKrcF32YIz9pW6VfehnlUhQiep0Cks1qANdLYMzpj4JP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QufWCkCMd2T9gBasdgt0vIa0PycNVUEmXvkVox2ciGw=;
 b=RNuoeJSdhGhpLLBE25RHwHs/E+pWo3zGLh3Qc9dxnRDAJmoZ9V6URg04RuIy8hgeV6UwuqrhAjors3VwBPpp47ynQpexmHpSklQ6qmdMFQcpXa4J79smBiRIOD86UxCDdotVH09kwO/gAn3CsyBqn7TZIiShyfN6UB0i6EC3qDppRruDJyjHGzUozbKeeZlAxUfI2yVy6/oDT7sG1c3hTEO4F5Vr5eIBVtycUCdxo6+OTWFiVcJcY5crcwKDCpnoEfHPOiXBQZyekDiBZaHrs7qugl5WM0fBjGFoxe+ZSbSdJ/VAGE3QZ4G+bUWf03YU52pMhCfW7UvsNX2xf4uOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QufWCkCMd2T9gBasdgt0vIa0PycNVUEmXvkVox2ciGw=;
 b=GRcxmzEzE0GUBiwHysygf72Cs/XklthkxDBk2z9xVhMzOfPdvNXH42Yi0Zd2npcp9+oyh/3LZq3/Zh/H2ff8VVCabd1vkfABPlqzyZICL/umuCcSp1xOuHeVAeNSCL2Fvqy7X8gJEshZPpXDzhrO74awTUPTwArmq48y5Gsysz0VKdIMmQcRxKGI7/H1Fzs87xYF8VqFppW0y3ydzo464zrwA19WQmj0/ZQdenIVk63C74iYxu9xtnD4POcRCZa035qbamH5KCSJgXcc5bvtA1RSavw/xWN2CsjVdtzG3FVgNHvZjnu85tyq2TnL3mvDt8HJWV7qYGLu9+Lcfi3VgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 02:49:07 +0000
Received: from SA0PR12MB4352.namprd12.prod.outlook.com
 ([fe80::3b33:a490:b19e:defe]) by SA0PR12MB4352.namprd12.prod.outlook.com
 ([fe80::3b33:a490:b19e:defe%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 02:49:07 +0000
Message-ID: <d130cf47-1d70-4345-b60a-795d463cb84a@pa.msu.edu>
Date: Tue, 11 Aug 2026 22:48:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch
References: <20260807201741.3275-2-nwhitehorn@pa.msu.edu>
 <20260812015433.1687252-1-kuba@kernel.org>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Autocrypt: addr=nwhitehorn@pa.msu.edu; keydata=
 xsFNBFuARN8BEADLKYsG3l1aq/M21R59I/5EsEfvtvd15ZJ9lDHcWPuxzIfGnu2LMpe5PrFP
 e/Y4bcsPrlB4S3I3ooIUDvoEEsDeqgqlZod3QevOK/RjLqiqx1i/4mKnobJ++3ppyVVIccgN
 sUrj786OYCFCI/W+uWw7cbKewNeaL//Z/TDKlHLkssiy6qmZbNQ0ZjcMLJKUesk4eVg2TtTD
 HNe42ZuxbUC9iLYieO4c7kQB4qiFhagDRiObXrLzvm2MQYeAaNVRqID+mfI75TWrQ+t98iVu
 mHvFu461eeteq59jg6H/IL07ACxL+HzEVM+D6tPtPrz7ppr3wiZL5Cu17yu0nAx0nhJTV8ZB
 qza1rOVun0x65S14L41XD2HkmBDxTaRlTg8ypnkLFo8kh+MEq4k67apL/DUGcaUjKy2TVUC7
 3igLO/DwQHrkWx2RrOmS3xS0TgGXVmB47nq2Zveo3fcjporQK63n2sbLkS70cfAJAJ9KHEIx
 u9am44iW5Ku3+mVLgQYybtcUxlk/Jw/BA5V6KUcDQMd5kTm0MyagziqMaT+57ceYxwRBK4HC
 DCLRpSOHV81/YzyL5vnwfHsxADm3091rd0uwr8uRCQn7wLvlcFyp/JKSFkVnE1oo7UE4QQJZ
 GbSJyvj7GdXu0LdghALcMj/thdb+js4D3UuCaAMecgVSscxEIQARAQABzShOYXRoYW4gV2hp
 dGVob3JuIDxud2hpdGVob3JuQHBhLm1zdS5lZHU+wsGOBBMBCAA4FiEEPWQg+qghST6Avw1h
 OLZNlGaE6HcFAl+ZtPgCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOLZNlGaE6Heg
 EA//Xh0wbMZfJceG4tPG+0mxyQwOmWEy5eaEsCUrQ9WvN5xYwMjJh34/6acPs7dJzmdJLi0C
 vIrl4pbVskJG/R83V4xLbYsRkRsq24FhFRNngCnyjfhbJF7cpSRWKSsnb9Np5HTJMT4LXtEY
 si7cg87TCxPM1MZRKDxKP5Va+hgbdlugvUvTgyNgO3G3jCSdY9Zhn2ylcsclUfiD8SOzdz0P
 +32lZsJX6QrlYaxmmVOS6Fy3gOni/9IVS3qugwGRd9XORAwzHYt/H8xlfacKZKkDj4AP9xjO
 buavCnT1jRO0hq8GS0dV3qKqQRuy+NgBs5FsNNyDIeOKEiy5R/6TtX1z8BdXnKrq5OGsVtib
 BcsxXKIPILrA5o3UAjxFikZOp3ib9kMWqgDyXK9GkwtwFl4hEznWKspDdeYRcnaA2s8iFEnP
 vqwGsLGvtaOWx+gFXDIF4L23GTDX+U/wDXQ655AAGrgRNq9903fUWgz5Ez2DmV2F1q/nLbKb
 nIn02dfndza2HIWyKf8NYc4rmjiqisxQm3LfU4psWwQep1qCIp7AtuajkWXOUGLXNJl2yDiS
 OFVSGWHidPoaBaUFGWscHkSzeMR9XkhHHBIdYUh0X9FD+6fCIFX9GIe+Ai7LL2DGx6q9Acci
 vGh9ZDzdctaYon03/NHh4lM1WnVXR5/tJqD3VynOwU0EW4BFQQEQAOLKFtg6us0ALA7Ltvjx
 IskIgqFJjHw2ka/UtdJ432P9kvmBq7z4v0+m/gkxCOOG0yDi2Cv/ALJobsyb56tbU6MU0SRj
 Tio35S2jit369B1BDC2TLNF337sUquUx0l4wkEXEBefvLRYouF8BRbkgjveg7sA4NjsiduQx
 92vPJnBoaH2OWxqDbr5X6kF5cx9jPrKUJ4ZqH/raE/SSDhtow4aKO0nWbteVGck15W1X/S8K
 ziPXKazxCQ8qprQRTAehsdG/bSbWD95hp3TAlEbl4N4UqqS7n4jCZunCeii2TDZHVvx/lpFA
 T2ezx646p2PUmH5hpiVMgbY5uHcyahwNf+eNOO7gotnNYoieoLw4fUeTYOq+s3INisCB4iov
 QcZOCYSzmwRolQRggX0tBSenR6Pgp38YjVIkWvMHhxbVifAusjvVbm/GQeA2MaCtkog53Iyf
 o7ri9DeNpVuRc/47BxHi8JtdyyGgLO13Ajcwc6V7KLeDmw/SXJAMssuWQlXzs8OgspNvtymB
 h5rq4TlxAY65L3Yv/yh0izEztOJO3Ob9y3gLrp7TeDI0EO9SyGuFXbgWY/NXlDwWHWguMgO7
 DWM/KxeaMYyHfnffIeQ6uhM21y42I7NV11mWwycv/XJkID3fd7GWBecakdYnYI/7FYMDHmsU
 QPmSMkbqCqYcZe47ABEBAAHCwXYEGAEIACAWIQQ9ZCD6qCFJPoC/DWE4tk2UZoTodwUCW4BF
 QQIbDAAKCRA4tk2UZoTod2RbEACbQ2bwJ3++bvqclErbekf7BXYja37/HxGE67q39xf28hen
 8vWGtXwq4bWmZT5H8bBqXigA4bUU4nN4X3xEDfTyqkQMuDTnnwT7Y61B4QEqhi4aq4adf/KP
 0l1UCg4CJ0KS931Han+VbiuUcbadu1ZX37Ef6g/hG+mt59FeXDMU0rers2Bpr8zB8ywojAsV
 C92kvOHLsCQtdCsPzC+R6B1bY6/Re9slM1NBd+2k4BUVhYu8Fb8Ir37OmN0aGQzYuRczfrmR
 /OV5/1+g5XeYSFbq/0Q3KkFWLHfimff8lb9GRWrdvOUpYyGluv49b/G5o9lSxPwXyBfaoVi/
 WDDfJ/XJw9H90XK68TYxPfEQkeuLEEzg+Bz3Zeduyo2Zx4S5apLqAbv0RzduXgIGYZVPu8R4
 ya8nQWHeUpot17lt8SL7yFkMJaAXk27QqUAaxjqnGBLn70YMWXFGySfvjgaR1Ftu/S/HSKqH
 7m8aFYZftqs7ZojXNdqGHZKRrIx6hRUYuZQM8uxHDweF4jF+QIwYIUmtry5h8itiSjt9KHjp
 kH3Wz5o1mk6cbFNN+wgpHplDl/iZMZjFskTAJfEsYHVSSm21zcYvvogrbqYvciMTty65+0A8
 Gz9tMbcNx9ePaGoM+9jeFehrzTjdaiTiC+umSd/Y29DCW4OBMr1VfufVVKbfAQ==
In-Reply-To: <20260812015433.1687252-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0055.namprd14.prod.outlook.com
 (2603:10b6:610:56::35) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4352:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2382b94b-736c-4cc0-12df-08def81c3fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|786006|366016|376014|23010399003|1800799024|4143699003|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4edHbTbt75wD/HvZUfJ/kwM9Nb3k1oTJ8/yKsOEgLcnEOaYedXxfkJ1RISgATCsAVTUNd3sh8QFzBvST4Pj/qZDGBdjjHz7PuJjmMJfg0P8/DrlJBPTHowNgZ4L3z6QQH0tQuqzQfaX4UC9zuVbRvaRY2d5toN9VI8m7/b5ROmya8ckF7iLxDRQKbmvhH+oUZUoStZO4UB+mq1nxLueFpgBJWYLsNq/mWFoiS9QkVBriwxHtI2giN4RzEwkufGvtkjtGifFPR4lnhbX1fkBvobabcdb4//ASIOrMmD9noYioFYMvWY7oNgSdGwY56KHdy5VcU02tuNNTXRG1L9HdB0OksD5XIYsNLQrUkgHu3Os1uj3sPKeeA3/LlGYvGSoquhe4K2vGvx1D18ithGGZufzhs9ntKsgjNdewItCiU/NXt2Qe9ks8/WPl42X/gxrYlflMpKUCisyfV06gI+eUG26TJqfVecMZ5DGH7MaW6apahwauuonVXW1+AkxC0qy1Q1m6t6nY3Qc/B87d4Zpj6b0pdoHAhFhKwcSuh9br46QDhbKQbdFaaT3X0EtIlryO1A0k0vTOywV5R+fT9UDM9JHgRJiE7+vZIrIW6LhvGLKlmEW2RqhScnhI45yNdef1PpxOOx5ZjJ3QMjIWK91Mj1M0EJlWyqUHlTs8wMbtc+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4352.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(786006)(366016)(376014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEJKU3ZERWhlRkptU0NGOXBJbXRIU1hiMk9RSVVISTRSYXR5ZndwRzI4eTkx?=
 =?utf-8?B?MFJycXZKSm16NkNvU1VIUmI1ZkJHMWEybHFHem5ERVNyYm5Db0oxa0ROeU04?=
 =?utf-8?B?NG1yWHJTRmVKNHFBeFBlMDEweEhUbS9nYUxBL2VWWjZBUG51UndBS3FENTI2?=
 =?utf-8?B?L0Q4YWYxNW9pT2Z0VnpnV1BaVXRKWkREaExNTGM4dWpCc2hvMXRoQWpLazZU?=
 =?utf-8?B?bWNici9ZZzVKUjJhR3cwN05meE5iRE1XZXFTYVNEMHc4ZmRIaklSUXdWWXRV?=
 =?utf-8?B?WDF4bDkxTjQ3QjJkWU1sRWUwTHNYK1c5STFOQm51Znp0K3Y5WmdYMm9QM0R5?=
 =?utf-8?B?d0ZjejFHZ2gwanJBeUVJQytlb2ZORmoyWUV0T2wvTkxGVTRVMk1VMEM1eFJq?=
 =?utf-8?B?MlhzMzJSUVFOQzAwSXpXdk91djhxUnZ0UTMrM0dzL2NUZWtSRnh1ZjNyQUI0?=
 =?utf-8?B?V3JjcTEvYVBuM3UxOWgrdGJmOUQxZkRXOThJQ2RJS2ZGc2NPb1VLblhERDBq?=
 =?utf-8?B?dmZVS2thUXFEQWUvWVJSaWtlMlZlVGRsaFgzR3BoZDJtc0Y1c2JtV21QdVFW?=
 =?utf-8?B?THdybitYbFpvNkkwQ2JlNUpzSXJKOFFvdlloeUk3UHNJcGJqSW52c05pYTNU?=
 =?utf-8?B?L2lYL3RYS1FyREI2OXByZ2wwOHdVcjNNVDRxVTlmbGtuUkJGZUUwTWtOY25X?=
 =?utf-8?B?MXhHenFTaDE0OWpWSEQzY3FmR0RNamovaHJ6QWRzUHQwalJjYTdGNzlCdzQx?=
 =?utf-8?B?UXY3c0lTdkJSUHFEeGJrcXhiMnUrS1c4NnJ6UUNNejBYdHIxTWJNZWNoN1U3?=
 =?utf-8?B?VFRwOTFPUmp1V3NaRW04VzBoM0Q5eXRWdHVUZUNHOXBPQmtFMU1NSUg1b2lr?=
 =?utf-8?B?MU9XWlVPajVRNUJXb0ZPa2JoRW5zbld5aTVNQTNTMmJxZzQxd1VOK0JWNkFI?=
 =?utf-8?B?aGV2NC9menUxc2pEWmJYQzZBVFZuZW14eFU3dHRMdlF0UUFuQVp0ZzA0TW11?=
 =?utf-8?B?MWdOVG1hekVUa1dwVG9tZ2tGMUY4a1d2dTZIQmJmZXg4ZmU0OHQ5VWVIWWJu?=
 =?utf-8?B?RTdubGtsQ1I1UDJFVG55aTY1VUdBbjdFQXJXdm1WbUdHem9uOStqOVdiQ0Ny?=
 =?utf-8?B?YmN0RmhzblRveUp4SWZDUkcxa3VLMjdHNmFLN1laTzNHTVRoOExIdDhoSExj?=
 =?utf-8?B?TlVZL2tnbUlHbkxKeXJmbkNHODc0OUZzL245alpTMC9tSVVPOFpScXdYQW52?=
 =?utf-8?B?d1VpcGxTVTNZK3NPWkt4K2FvMjJ0Ui9sYmxkWlRRV243RDNDUDVENTZZam1S?=
 =?utf-8?B?VDVOSUxqTUx3VjRVYmRYTlU4dHROMnRiS0F3MXQxYkR0ak81czFXQS9zM1hP?=
 =?utf-8?B?VFdJNVViZ1k2NlBVTDR3RmRWRVFKRVJEaUhXTy85QXhkd1lVU3pYQTNPYkJw?=
 =?utf-8?B?VXF1VjFMZ1IraUtaN2ZnbHZjdCtHU0F0UFpiVE9LdEJKWVhuM05XRnJFTUo5?=
 =?utf-8?B?enV0UXJpbFNTZFpqNVppc1oxNHVpbStxdS9ZM0NJSklLWVEreXhNTTYwZnJJ?=
 =?utf-8?B?em8wbVk3TGNTTUo1SGVsR0loaFBIRm8wc0hJd1kwbVY1amJhQ1U4NGZyU3Zs?=
 =?utf-8?B?TlVxRVY0YWREMjlpeUc1eDcrMndMYk13b0lLdDlpRk84RW16Y0tJaWJjN1Qv?=
 =?utf-8?B?K0o3RE90MUR2MG9wT3FLR20xS000TDFZa3VzNTlDYWdpQUYzanIwZXM5dTZs?=
 =?utf-8?B?U3lrTEdFUGx0dkxJU3gyWXJPcytOSVdxbGVDUjZSOVJmS2FzekdPa2FmNzBB?=
 =?utf-8?B?UkJZZHFsczdnb3l0WmRPby9IOWNQaklkMTAyeTVndFNVLy81b0dCdEUwRmpw?=
 =?utf-8?B?V2hzaUUyUDh5bnYvK1N4RVVjRVBsOVUrR2wvK3E4QWVnSVQ4WHZreXRZOExG?=
 =?utf-8?B?VERzaTNIcU5PZCthaEg5OWw5T1V3cy8wSmZNVWhNRkNkYmx6d3pmanFIV2pv?=
 =?utf-8?B?UHVlOUo4UFBLcCtBOW11Z3MrN0llSFVQOURkSjRoU3ljM3B2aUNZNzhEZUVO?=
 =?utf-8?B?dDdNTlEzOWR4WE5WcXY2QnBUYlJqV0ZwVzdob3NxSEw5eWhieWxxK3o2Tkgz?=
 =?utf-8?B?Q0FZK2FxVmdMUVowS2lzS05uOXdxZTBNU29ud1UrdzBtZG9SK0cxMnBwV1Vq?=
 =?utf-8?B?ajZHc3JCcnFXVDVyelh2U2dXR0JIZEpTZFlaaHFhRUlIVm8xUnp5ZnQ1cGl5?=
 =?utf-8?B?Si80YTIxTmluQnFtdFRyWmFlU1BscjJkNGcxQyszK0Y0bGNmSmk1czVCRVly?=
 =?utf-8?B?aVROUWw3Wi9PUTRRa3ljWEp0VXdtOS83YXUrSFJsclFoZWl4TVM2djBkWG5M?=
 =?utf-8?Q?EKNMVHMyYk75R1Ivv70HZpuDvoAkpR3oMjzBvf907D4Hg?=
X-MS-Exchange-AntiSpam-MessageData-1: QDEXBZK/8y1rxA==
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2382b94b-736c-4cc0-12df-08def81c3fa7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 02:49:07.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH6g4JHimIcTDB5MF9J0uk1fUu7lMSkoRti193zadr82IB8OqxO2jf0X89+hsGrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225



On 8/11/26 21:54, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: macb: Poll for link state changes when using the internal PCS.
>
> This sets phylink_pcs.poll on the macb SGMII PCS so that phylink polls the
> PCS for link state instead of relying on an onboard PHY, which is needed
> for offboard transceivers such as SFPs.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index d394f1f43b68..c15a9c7e69d3 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
>>   	struct macb *bp = netdev_priv(dev);
>>   
>>   	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
>> +	bp->phylink_sgmii_pcs.poll = true;
> [Severity: Medium]
> Can this silently disarm Wake-on-LAN across a suspend?
>
> Setting poll on the SGMII PCS makes phylink arm its periodic link_poll
> timer, since macb also sets phylink_config.default_an_inband = true in
> macb_mii_probe(), so cfg_link_an_mode ends up as MLO_AN_INBAND:
>
> drivers/net/phy/phylink.c:phylink_pcs_poll_start() {
> 	if (pl->pcs && pl->pcs->poll && pl->cfg_link_an_mode == MLO_AN_INBAND)
> 		mod_timer(&pl->link_poll, jiffies + HZ);
> }
>
> That is reached from phylink_start() -> phylink_mac_initial_config() ->
> phylink_major_config() -> phylink_pcs_poll_start().
>
> The timer is only cancelled by phylink_stop() (timer_delete_sync of
> pl->link_poll) or phylink_pcs_poll_stop(), but macb_suspend() skips
> phylink_stop() entirely on the Wake-on-LAN path:
>
> drivers/net/ethernet/cadence/macb_main.c:macb_suspend() {
> 	...
> 	/* Enable Receive engine */
> 	macb_writel(bp, NCR, tmp | MACB_BIT(RE));
> 	...
> 	enable_irq_wake(bp->queues[0].irq);
> 	}
> 	...
> 	if (!(bp->wol & MACB_WOL_ENABLED)) {
> 		rtnl_lock();
> 		phylink_stop(bp->phylink);
> 		rtnl_unlock();
> 	...
> }
>
> macb also does not use the Wake-on-LAN aware phylink_suspend(pl, true) /
> phylink_resume() pair, so pl->phylink_disable_state stays 0 and
> phylink_fixed_poll() keeps re-arming itself and queuing pl->resolve on
> system_power_efficient_wq, which is not freezable.
>
> If the poller then observes a PCS link change during the suspend window,
> macb_mac_link_down() clears exactly the bit macb_suspend() just set:
>
> drivers/net/ethernet/cadence/macb_main.c:macb_mac_link_down() {
> 	/* Disable Rx and Tx */
> 	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
> 	macb_writel(bp, NCR, ctrl);
> }
>
> The WOL register and the queue-0 wake interrupt remain enabled, so the
> driver still believes Wake-on-LAN is armed while the receive engine is off
> and a magic packet or ARP frame can no longer be received.  Clocks stay on
> here because macb_runtime_suspend() skips macb_clks_disable() when
> device_may_wakeup(), so the register write does reach the MAC.
>
> The opposite direction looks odd too: a poll-triggered macb_mac_link_up()
> re-enables RE|TE and re-writes the per-queue IER with
> bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP) after the RX queues
> have been tied off or set to MACB_BIT(QUEUE_DISABLE) and NAPI has been
> disabled, on an IRQ that is an armed system wake source.
>
> phylink documents the intended behaviour for this case in
> phylink_suspend():
>
> 	/* We do not call mac_link_down() here as we want the
> 	 * link to remain up to receive the WoL packets.
> 	 */
>
> Would switching macb_suspend()/macb_resume() to phylink_suspend(bp->phylink,
> true) / phylink_resume(), or otherwise stopping the poller on the
> Wake-on-LAN path, be preferable now that a periodic PCS poller exists?

I am really not sure, to be honest. This patch just copies the existing 
logic for the fixed-link case, which also polls. I'm not sure things are 
any different; if this does happen -- and I agree with your logic that 
it could -- it would not be a new behavior.

I am a little reticent to include fixes to this pre-existing situation 
in this patch unless it is unmergeable without doing so, especially 
given that I think a full solution would be a substantially larger 
change, but if it is needed, I would be happy to work on adding it.
-Nathan

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


