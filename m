Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBA20D4E9
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786682529; cv=fail; b=TIAH55ZNOB4zv8yICUQQMd4biv1tJspvw9Wh6KCIw5rUOKQHg3cXZ+tGigh3cOzITukb6/bsES+fgmvgv8Cwsp5C0ShwXyFL1owGsvXqmr6RFthag2GOGlhA9YuH8o+qUFPYwXp5ov6W1w6sl4c7P7Y1DTL9VzsVnPGf32FHs7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786682529; c=relaxed/simple;
	bh=qS6sOib5kWEMl9vxqfsUbXZwhady88TL7wU1o26HVzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D6eeE/AUxOiaWmL7f5JuqNQNLrFZj/xfXpN/UPl5DsV8jHO+OTrRzO55OEL9Y5OlWQ+d2ue9vTp5X9/QpUM1eTMwnn4hXbEuuEJdLVvmvCtYlBNdh1Q7j4dcWPd9BKsX7nK0Kv+3d1EatkoMrC1zd7jfMI5eNwGv3C8h/2SX7Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yt9fBomi; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yt9fBomi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3YTKhja4w975OtqioxsQa8giNjsIGZHWYDvIjr3zTFawJ0v1k+8PTIWTo/LPgJpMxngXoQSu5CCbLb71VabxqoiAYlyiaZkxWrEccmeOnhw4f4WZaG/btW3HQZL+v4mniwliUzc4kzQFtYVLovOw7CY+fNE9cpctGmmhnDAwjEJkE1epjjmm4w5HlVqdnuYKr385Xp8+n7yu1oK4oCRDmx8+r7wbCKDyyXEZLW+tcfDmuYzQSjmBSr0/ZLykJU8HLVK8qPHRfir/95DCMwNPi+PfUk1dCXniCia66hTYNDNO77CSc1V9G27SsSLnn3TYo9pSLWWPsgW6VAl/3C1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnZmqggoGoBGl1mXdEuRrBNrRWXE3f+YkAUvNJdWd/E=;
 b=MPYwrJWKY+gNB3+uW1N33cvPg1Kn9/rdi1ddAcS50A4nQCxgU7rfGsTle8UoAPWHq9qI2/7IEXwC0YCScg33aLcwqk+f1RA+WkSQ1R+cNNiFq+yEDuu9tF/1nhiUALr7WUK7aOXpAzavAh55siRgOJlGiipgjXQmwmarem/gcNOrxckz3Pb9nG5dEpl4OFg3PBH88Moh85HBWyDtYqWD5usbjU6kUEAgRU0fF8UrG4ReJl/bS/F8DtOc5ODbkMI2Xj8GcIivLG3swT0fcDYbtocmay4F/t0zqsdQrtYUDCOXGOBvhZ8J+fGJqaW3HoHQXcbhsGUzQcow5qHTLsC71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnZmqggoGoBGl1mXdEuRrBNrRWXE3f+YkAUvNJdWd/E=;
 b=Yt9fBomitr/H6x4fg7jklRBXXjmGrxxrwEq1TSo3I/4X6+oruXTm7PuHeLfCqbffyLNd8KQdKGlb/SnkhDx6cYboOgZWWId/hau4vqzuDFJILXTqIJIEY+bW2W/gsJtr+1VIpPMjBY4cZl+94arx0+rmZ07/qITHpOrkb9gEbUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 04:42:03 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 04:42:03 +0000
Message-ID: <a834d76e-9b31-4241-9442-0a69ab96cfc1@amd.com>
Date: Thu, 13 Aug 2026 21:42:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: Add .get_fec_stats ethtool handler
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>
References: <20260731214021.15279-1-eric.joyner@amd.com>
 <95d9b473-71ea-4324-b673-db68140782fa@linux.dev>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <95d9b473-71ea-4324-b673-db68140782fa@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:610:e4::29) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e323300-5faa-470f-927d-08def9be62bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|11063799006|56012099006|10067099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2jrjesxi7RbPJl5sTM4/FV0MmUXkTIdfrOcqPC/2a/FrcaGP3uLI7IV8h5AWITgK+KdJ7DjxViGtXNZyilSrEDLHpVCAGBp33QWKKkDuwBlufmGgLZTwFMrNOliz0zFEMI2a/gmWMYElC4F4kaXB7LERhbcIrZN0KnUhsvcTq2V1vqkoT+x/fq1Uihv1nCJ9VgiENfxxvpnxuqodQUlfMH7GhysoaeyIwmcb6nnPXjqGfYZXS3/1F4CWs/Me1/V95IbRjn5ptOCaxMIvzZ3qJ0jPu081+e+fAhORiFAeWL9eWxYzxR5V6E6raHIzhp2r4vnCbrPgBCavJaxpo1BzJIX5c1/CHKXuHVSPta+acHC++w8PKwBJdFPRtqkIK67OzDKTdUUhuoiU644nFANY411FZP1oKMMzio8AEL1xB30ZbZmweJravsy2tBQ+o+vw/rSNancbxiPalMoqx35uNuTuAqHrPRo/GsPfi3b3rTQSyYXvCPsfAELnOMFmY2lO3l90FikW/9bskSdjY56FqWfLW8iDFBT++q6HyFWsdLsWZB9nJZkUZstTE9JtabejA+1LGxgkCc8FG4b5ne62b2qTNaCvPguXuzt6R8zn2jSuMwUQmWDrfL77YiJsdB56gw5sUSh1nL8eNkha087TAMxAq5YpZ12Jp0EHL9KZHCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1CT2FvazNoVXUxV1JoTjB1SEdHMERUZDBoeWJJeDZJU3BQRU5meDJzOE11?=
 =?utf-8?B?b2FkV1FzZWlrY2Z2R1l3SEFlWE0yRHlka3UvcWhRcUwrZk1waUZ4allKL0cz?=
 =?utf-8?B?Q0xYSjdmVlF5VGRsRXEwb2hlRVlsTFlRY1VhVWRNdGpZZnV5d0tFeGpxTmR6?=
 =?utf-8?B?Y2ZrZjlpa1pjeXZFZkZ1OTVpZDkyVU9PZHczMmZBVE55SmtxOGc0bU42cTNv?=
 =?utf-8?B?U2xGWHovU295bmdmcW0rSjRFOXQzR2JuUEM5QmY2WHV5aHl5RCs4d2hhdFJx?=
 =?utf-8?B?V3I0VUpjV2wyTTJueGpRd0R5ZWhmUGFGRnM3MC9GSzJQeHhqbmJjcjAzOHFX?=
 =?utf-8?B?eDlWMmdBSEMyYkpBQ3IzMW5OMXhRc1doakZVVWpKeitZSjczSUxiNVdDQnQ3?=
 =?utf-8?B?c1ZwdWVPZmJqMUxMZFFlUE5GR0tVWE5hSXVtN3NKQ1grYUQyOXJHdG9Sc0di?=
 =?utf-8?B?OGZDRGRML01PUjZEQUY3bmJzTTRkWGtQZDNEWVBxQlZXVXhwMFpJZFdQRUFq?=
 =?utf-8?B?ZVhVVGhiQTNYc1lDS0RYbGpnMklNM3RHelBJdVBxQzdodDRHUm4wRjBVYmpu?=
 =?utf-8?B?OXdkZjhyZWViZ1VLZ3k4WjZBWUNyUlJaRmcxRVh6NHZlaXpxQmhvRE02WVJI?=
 =?utf-8?B?YjQ4R0hJd3RIZXAvOUEzVzk5NzN4Q3dEbVpUMFc4dGVSVW45NFdQZ0JLZEJC?=
 =?utf-8?B?NklZemxrUHQwSDRaUVd4aUg0UTduT3VjQWlMcUJzVDFMNTQzVHQrNDlyT2Fz?=
 =?utf-8?B?KzFhYkc1MndTVHJOQWNSWnJxTjd1ZHJoUDdTWGhhM1doOHFNQlNzemkycFMx?=
 =?utf-8?B?YTZtdVZMcDZ4dUxIYVV6RjNaVWZ1TnZ4cFlmZ1F6NjhOY3VhVWVYQXRkQ0hn?=
 =?utf-8?B?SlJReEJOUFpEVlA3aThjdzFhNVZQdHVMVWp4ckptNHordG5qcW5lRXovYzRC?=
 =?utf-8?B?amx6S0dzdjRtaEc5ZGdmK1FsTkR0NFIvdGcvZkFMcEFueUtOYjRNWUt4bDRt?=
 =?utf-8?B?dUZBL0ltVTBsT1NVSDgzOGxLYW9oeDNpRmRHQitLbmVyWWdDRklTbjBzYkpI?=
 =?utf-8?B?ZjJrTmtyc3l6QVhGOVowSUgyL0ZFdzFuSWo0eEo5cUh6ajJQTG5BQ3dPMnhL?=
 =?utf-8?B?Zm9HNGhrQUdFNTYvZzR3R1VPcDVNTVpVVU5BZGZPM0g1V3RoVHBBT0FqS2g5?=
 =?utf-8?B?UEhNSnEvYmVXUE45c012MTYwV1Q2dUcwQ0c1OGp5ZjFVeHBvSk5DREN0NnY3?=
 =?utf-8?B?TnYwaVhPNnBBZlBWVFBsZEM3aWFxbzRneXQrZWJtc1FWL3hXeTBTWjNOQ0V4?=
 =?utf-8?B?Vy9jUytWcU9EWE4yVzc4TFBBUy9QdmVLUmIrcCtzd2Y1elZpNDh5WlJQTDFx?=
 =?utf-8?B?Ukd5anU3RURPOWw4cktEbW5vdldoUlBGUWZtbTg2Wm9jZXJIeFFHRXJCNHRl?=
 =?utf-8?B?Y1RjSFZ1SFNoYy9hUXNrR2ZRMkZUVlNpRm1kN3lSVmZraldpTFBqNkRTZnFu?=
 =?utf-8?B?ek9JSWdGME1aYTBRc25UdFhpNC9YdjUrUFdoaDNuaWxBYWVrR2pUWHJvbWtJ?=
 =?utf-8?B?ZUl2MlZLSFExMFdnUnFTaG52M1o1ajB0ZVUvWVRYa1BMWFYvWGdQQ2pMcjNH?=
 =?utf-8?B?K01BVVpITWpLNmlRWHdGRlEwYlRpQ2x2eXVBVWZKK2t0MzBpcDVIT2RsbTc3?=
 =?utf-8?B?Mm1jdStZei9PeUluTG9hcjdEdjVCQVA1OFF4cTV3L2Y2Wlp6QnJpdFdSaXJa?=
 =?utf-8?B?YzdZbkpJcWFMeTZIYkhjeUJDWEdNTmJyWkh1SEdMend0aWJvTDZOQm9JV0Ra?=
 =?utf-8?B?UmdMTS92eDlnRTYwSVNTZmVCaGlLeVVteFl5MHlnNEF6TSsrZFFRb042TmlS?=
 =?utf-8?B?b1VWREpvUUswYXlBNVpaNmNHQWt1TXBGbjNkSXJ2NEk0NkduZFZsbDdJMGpR?=
 =?utf-8?B?TXRzRjUxNGd2ZWF2bVZWbm50RGcyR2MxYnA5NldCb29lTlIrdGE1NHBKWVlN?=
 =?utf-8?B?MjF1V3U0T1V2bUZqYi9obUdCNGJhY3pCa1dWM3YxcGRhQS9Ba3J1b2NPck5T?=
 =?utf-8?B?UW9rUjRTdmM5S1Y2VklvczIyRDhpUFFvTlBCTmJzeHBYdWZnL1diVUovQkMx?=
 =?utf-8?B?c09SZVNEYWJFWmJZZlJuSTE5OXFFdi9XdG5jNWRERUpjdktjTmV3RHhXcmlP?=
 =?utf-8?B?aWEycXBvYmJ3b0duNDNQNEpjbTZDeU9CQW5wSXRtdFhneGFrS3gzNHJDRllF?=
 =?utf-8?B?NjJvd0JVK2RTeElCbGd4cG1VVnM2NkFSclJHeTA4ZWdYMzY5QzBaOE9wRVIr?=
 =?utf-8?B?ekRFS1FzaXByeUp6ZlRkTnIxVExSRHlxT0lKTDJwa0RzMjRuOE1uQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e323300-5faa-470f-927d-08def9be62bb
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 04:42:03.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrUvGe9Tm6i5UEEvCZNYl4U17Kcxwu0HblHs2GsJFCsJ320Yz+UYOLQswBdYH+Pp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154

On 8/4/2026 3:27 AM, Vadim Fedorenko wrote:
> Caution: This message originated from an External Source. Use proper caution
> when opening attachments, clicking links, or responding.
> 
> 
> On 31/07/2026 22:40, Eric Joyner wrote:
>> Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane counts
>> currently aren't supported, and the only expected histogram format from
>> firmware is the one with 16 bins from RS(544,514) FEC.
> 
> does it mean the FW will return IONIC_STAT_INVALID for 100G CWDM4 mode
> on newest devices?
> 
> 

The only device we have that supports reporting these FEC histograms doesn't
have a PHY that supports 100G CWDM4; the IP block for it only supports PAM4
media types and not NRZ. So for now, it would return IONIC_STAT_INVALID for
that mode.

Though, I don't know if that'll be the case for future devices; maybe they will
support FEC histogram stat collection with NRZ media that has fewer than 16
histogram bins. I just don't know if it's worth supporting that possibility
right now since I don't know when or if that will happen.

- Eric
