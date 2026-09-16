Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010016.outbound.protection.outlook.com [52.103.23.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11364AEBF7;
	Wed, 16 Sep 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555302; cv=fail; b=s9nLCe4RO8gAhu2oV8V3cRrVffMLWXlEhgAbM3GJyKn8tOZZfe7NpAL/iLtMQ9a8p9DR817rm8rh5UBmUypS+71JHKF9rk1iPcBFtc+XtsGwlZuOiWMgGfTNVctaX2DWlAX0PmZV4kGZvi9C4DkapbKnTut5LLj6xp1A6jalGbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555302; c=relaxed/simple;
	bh=I3/t2NfFW2sXomerku9I0Rl0kFpvKmoZj0xcQBj281Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kdorAXZfdLM5Qiu7k5bkSjhC1wDcUuiVoOLuQITgVJPrIb/QLUnKmetfEWYdobdSkFBqumoJ/L7yWHletk+8jE76FpQODW+uYElJb06bVsmXXsqd45WMvWSoHuDltslEBtiTTMKtmogUc9vLWwLXvBrvGnxqONHk8jtCt5ChvD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DvM3/UTm; arc=fail smtp.client-ip=52.103.23.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DvM3/UTm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXj7BSg+w9q2Ra5kdgk/H7zLPfcg5Ve2FlAbfDuP1BosLXrmYYsRG0ECB6nvMLUGPgVX0adAVQX/anacGyfSXIabJ4sBU3ya7uYzmpr9gy2NxcX7K2YEXw7cSOkL4DLiIgxau0djXPQ+0a3UH3EwknoQyo4VivQ/wC6ak/fH9Rxpy4spZ5P3JAU0OXTbdXeWVlo2G9f2XPQ6HTDpzyR+BzTIoKlkbLK8ZBPgUkfm5i6SBRADXHKBpzDnZeQI60/CC2ojne5RRWYDai26oDbbPjJvapVPH/j/NnlaZEJqfqgR+N+R1FBvv83IgTN2zjgXfJFznMn2dKEKq5XaYko25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJiVK2qY+H0B057/s/OkdwNxxT96cCaaJFfAHUjZ2uE=;
 b=ERX3RfgHlQMyQeQ+UM4KNSD4xv+qdN1L5GvpkNlCrILEbXfnSUW8c4+sUNwDYH7BQsiWjFQ3F6y6EFlyAFX/iP3alIMccIlq7BNHGlxdsqtZEPt8qzrspneYtsDZz+Cpx/cO/ckH6lpH/e4kZ5l2Is/Utm8+lvgUuWa5EiG/ScBFlPXYOq6116hlpAmaQtR0GvQyTiQ7w7HrW0xCHT19oDKrTF6OFUE8mSZxSH3YdtAJr9W8iuYCafMFl/M1hcqblj7rL2QXCrDCFm2vm/Ejdt2BjKH1VZz+cWbGSLt654PRleoPqiKicFceS6YQOdd4GtYwb4w0VMwGyE7/zRKKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJiVK2qY+H0B057/s/OkdwNxxT96cCaaJFfAHUjZ2uE=;
 b=DvM3/UTmYq1z1Nv9Wz0VtRjKCGq3VErtKljDcDJ39e3I1Rht872Nj1yjkw+4hx/SzBKdW3ylnOuwtji9aRk8ESsfzM572yocg0rfHRxTez/rwCnp+MGKNID8dVHfncNowJBngebWsQ+MO7+5KZlVbHaNbgGqh8fUTLxdXgGzcmhVyMcEsg9u0BXyDZerWzXIX080x6DuYyqMi/roIhKYhTxfaDKXQRcZA7VGdKMXDLY9C6gqz4M2Sfts7EKgtYkZ2UicWtSEeOrFWmT9oMmuaUh+5LUaDejEMkCnTQy5lTjCanStPpO0oRWjy4JSLJ1hAh16lMPeXSqKhGcaRiyu+A==
Received: from CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 10:41:15 +0000
Received: from CH3PR11MB8413.namprd11.prod.outlook.com
 ([fe80::5cba:cff:2a19:7d1d]) by CH3PR11MB8413.namprd11.prod.outlook.com
 ([fe80::5cba:cff:2a19:7d1d%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:41:14 +0000
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] stmmac: fix ETHQOS SerDes interface handling
Date: Wed, 16 Sep 2026 20:39:48 +1000
Message-ID:
 <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:220:1e5::10) To CH3PR11MB8413.namprd11.prod.outlook.com
 (2603:10b6:610:170::8)
X-Microsoft-Original-Message-ID:
 <20260916103950.41510-1-tom.karpiniec@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8413:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0d4ece-fdc7-4a0f-a1ae-08df13df07aa
X-MS-Exchange-SLBlob-MailProps:
	ZILSnhm0P3mCYd7/icPJlj+s+m08RC6kNef5q+OLiNZfQBsyEZWRq4Sam60CoVMEBMN+iod1IlN7HXOQNbtT/1ytkE6HnMv2vOSuh0fcXtTReF53Az6K1bZQ+7kHIJ+JfQ94xS/5tZZpQ9ybJrlna0gg/3FTNGMhdQ3lMlXCx8/mNqqBfWfShbtbNzVj7rY8qGNJiWiYnKiUTlI+FTjr4ax4wYJB8rVD9ij+MrhB32OeSmaNA0DT5pmOASftFCQfXJoIQkaDPlQ4sUNuGRaYvKA6woHS6L4PnYxkBisSvR08uJQNEukD+BAOT82ODYusLT2wqy45V5lItR89ptYQsEv881XaRWUtVqClgituTQuv8kpXFqvUL7XULNt4LGtgn8ZS/JIo6H/LRfXP4Pt+hEyxWxYf0m50RjEVb8NBMTgG9eLAb8zfScbHzRMCtnkeLyFYqZqCFEkQodOgQwio7l29H7pTVCUavo65gviD8S5UmmH53Hc9u743pSZGK7mRKcCPqpqYgFw9WKGxa+0M1sDALmK2juA+zs+aQWS7zKrJWP6vLsQpMBcPUy8OLkuvBDTCNHE0zMuNGRL7JD+gvzfBP8xC1g5q3UsspHsDJVahZwzpGlUWwKovj1MDLshL3vvtbLCGbCrCKg1Zow6dnYpJWe0k8trQQgLE3v9rPz9yNcxhKr1U58KXilbph5f4Bf/8uRyXQ/hjtWeDzl9Ias2Bmb+PIr68ONS26fxpt27dNX4Xr/DOoQytfGvuvQonyhXnBHuSfrbinJYMAEBIUDc/tsS8MDme
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|4140399003|19110799012|8060799015|15080799012|39105399006|20031999006|37011999003|24021099003|23021999003|440099028|3412199025|40105399003|41105399003|30101999006|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wx0oHjV+ZPYoDpq6uCGdrttk7oFtC3ztTac6h2NS6ibeV8HuwF8WPq3swq+a?=
 =?us-ascii?Q?W8sEktUgTPw+zRyE7ht0rdy7HtOAjKHur3Lwu+sFjeMrBXXk/34w4olBs2Z8?=
 =?us-ascii?Q?4a9vr2/jD1tvgbBIH0+SKOlVQTlR5Sc6BRPv0/KCKjKODGuX+SS0BH8EF6sd?=
 =?us-ascii?Q?wPHPQZq9ua6twKYnxzCyU8XWlkmwNRLBqFKprMewo4MerXudKAirq5KrrNYr?=
 =?us-ascii?Q?ZKliHkJKXnZXCxFsbprfXnaTW0vdBsHgoQK51racY5qR0SEX+1KShgjvFb4w?=
 =?us-ascii?Q?jx5qz/nXe5xYd6vsbWFhD0lxiqafNFYKlksiPp8UHkaYzNo1niYguvbI6vMF?=
 =?us-ascii?Q?iGvz1mIXbNq0K/Y418AtllkooW5poZ2wqPQxl3j9Ch7XttpFZ/8Ye18qeh+r?=
 =?us-ascii?Q?IEvB2o+fWAScTb17miYpndm65s1tk0ajQP3zsufcVYxyK938F16meVi7sPqK?=
 =?us-ascii?Q?Kmn0al626Ew4hy6/ssjeepiXqlkqBdxN9y5J6THz/MXlWdENbQpc5XTEKgMZ?=
 =?us-ascii?Q?zx12kAKT4cZn6BuOUjNKiFB0S49iERt2YzaQGICRAH3CGiBnTlocBFg9gSQm?=
 =?us-ascii?Q?MeefN8PLzqsHDrV52e4bmEbvoepPFXWNez7u5VcjYaZPMk36w8g1TMSqwQOS?=
 =?us-ascii?Q?t6KIo1zisJcja1uqbniEToCxF+kTVH8yey3mXgqoU1+ZqkxiVuw7K++2OJNn?=
 =?us-ascii?Q?XlEJuPof198WS3eUH56T/amPkFLFs82mMY8t2D/T2WXwNasSHfxOaHKD30B6?=
 =?us-ascii?Q?pjMZc9iNU6ywT7tSUJ3QwSGCtisN6HgicI+PWsxADeerVa6wk9DvUSbPawvH?=
 =?us-ascii?Q?zJRkHnXJatevOYgYFDaxDfLg9BygzBB4rKGMjOeqPHz305M7Ov9pOC6s3GGY?=
 =?us-ascii?Q?yVoUt1vfcHKxwWj8l/NoowNA456dllLuR1YdnlxF4wMY/bn53G8icTiHuUAi?=
 =?us-ascii?Q?6GHAkYnw3uJgT6IFCHczPVMAhCShvUlSbt6UK0cElopK1FgkGwxMlOtPwwk6?=
 =?us-ascii?Q?OFjxtl0nQHXj17g/vUwFh+MuonBEJiaX3+wUbIWo47tgAD+91Q1TfPCAW141?=
 =?us-ascii?Q?pZpLe8ty?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CnB9yxPJHEuLaHYO7EWHlX43OX27/ZgRVz6kG4CfE/Otjjz7plwejKz1iMm?=
 =?us-ascii?Q?Id1AJLeHqd8ysPuU+fWGsmJ3aIkOU1hITomp6nUZxpWHV145GvCwKPcRPPfU?=
 =?us-ascii?Q?CAK2qEL/hbbIsBaE9wM9Z6NrZCx12h9SrVIAhiGjukWqmaBP2gNCSoaIpGbt?=
 =?us-ascii?Q?TwHuJHBKpaoTL2x/kJdm9OnRc0RlvtP61m0er69+oXuxn6JomGBL923CmWm6?=
 =?us-ascii?Q?lTcnhFCnqxaHeAoYzAdyZBz/JNfj1eZFvAPqoxJsl9WqC/CPKfnMeTP3Jnmp?=
 =?us-ascii?Q?nI3BBQQKz+0009vQo7tIh6p9CN8jEa1EdjiPMzHRYyeN38MGf7VhrUSY91OP?=
 =?us-ascii?Q?OsL4PBlwLsHQcZb+OqnelM2TuMr0DMxQCf3Yspf2MYRwxOgBW297oec36L77?=
 =?us-ascii?Q?izFaA6WCvcWBtGSRfkIBkOhMkuv5ugbnupfbvzeNdgHDDeE49ConPrYwzUYs?=
 =?us-ascii?Q?NvxCNkMBa+ZkZk4Y9peMUkP/B6IlWS0TFfQebmKNnoRu93RrO8IHGfmse5pD?=
 =?us-ascii?Q?O/SX+cOodcs8VQczyp9ONaAgv7sROKeEf/0KZTJL52HZ8vBg2C1ULvhouARE?=
 =?us-ascii?Q?2xMOBZIXkOeEjItl0aNtfhF20pevOcamBGzjWAPbs5nLGZRqEq8o/vRn6rTv?=
 =?us-ascii?Q?lR2Hxi6eYMgsnX+7LCNA5KZz8fDFwhdC2/pD5pO+z5G/hzxEBAVCrNgwqPwn?=
 =?us-ascii?Q?qnL94W3l9JhwGFZbK9p6LKS59he3M0UPQC3XKLFQ1sp0ELpVyDa6ohvGSe23?=
 =?us-ascii?Q?hOT2TfhKYy7SnwzroWEWpHf+jkt3qidia5RbDUJmzI1aApRWID9Q5/xJ4JaJ?=
 =?us-ascii?Q?T1V+LXbudLVK3aE/PYu/7Mpqboc3kap6x3ZWLHy8I08Cw71l3VcEgu+225wQ?=
 =?us-ascii?Q?kgORoDm4HU6GQD1sfqzEL/cN5MCTmzpfl2P50dCwoUqHKQmLbVbSiZHCEV8R?=
 =?us-ascii?Q?pHPkm8vES/TdNTk6X5Bhzd1Gm1mup8vxjyfkzgfz0kj3MKesF0cVPUspimXK?=
 =?us-ascii?Q?bF+so2aRW61PXGPiXMSA8Ut0QTKn2BRBuL6nnl4W61h+dV8A+yQhlSRyc2VO?=
 =?us-ascii?Q?TDkjIUqJPt3Cw7ukdpunpLfueA8fKNWCh4mERbxrcNNGG6T8+zHQB2LRlRoe?=
 =?us-ascii?Q?ICijHlpw05tqosbFqZmCWRJfPcyrEgPdPaUrE1b1tB89wShjL62CWn0DLYpz?=
 =?us-ascii?Q?C//Lcfz4/JaFcdfc2J9D692YBiJQbsgM63MUVArSbagnxGgCdWoYzUQ9toot?=
 =?us-ascii?Q?Izx8Yx8RPdPwxvqqDl+FKhG7BklHgGVm5QkCq2/Ilaf0i4X/Yib+4ysPjD1J?=
 =?us-ascii?Q?m/n1Ajpezs2cNePg51kcCANos+FbQkIQHe9f+26tEqL9QXoV7LcOIFWjkr+V?=
 =?us-ascii?Q?IBKdGk7Fwiomik/scBmuWv7EMHcz9kseBXnemg9OpXFdivs3z12sISKwmr6d?=
 =?us-ascii?Q?2PkyssR/vIMPeuxBuIk9fj5pGuowG+BJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0d4ece-fdc7-4a0f-a1ae-08df13df07aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8413.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:41:14.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129

This series fixes gigabit connectivity with ETHQOS and a QCA8081 PHY on
an IQ-8275 EVK, along with an error-propagation bug found while reviewing
the same configuration path. The first patch passes platform mac_finish()
errors to phylink. The second advertises the supported SerDes interfaces
so that phylink retains the PHY's lower-speed copper modes.

This revision was built into a WendyOS test image and booted on the
IQ-8275 EVK. Tests covered boot at 1Gbps and 2.5Gbps, physical cable swaps
in both directions, stable carrier, and traffic at 1Gbps. Injecting
-ETIMEDOUT at the platform callback held carrier down at both speeds;
restarting the interface after disabling injection recovered it. This
was a synthetic callback error, not a physical SerDes failure.

The tests used regulator_ignore_unused: without it, the upstream board
tree repeatedly lost PCS link. The vendor tree has a REFGEN always-on
workaround absent from this tree. No extra kernel or device-tree patches
were applied for these tests.

Sparse reported no findings in the changed code.

Patch 2 uses SerDes APIs introduced in v7.1. Older affected kernels
need an adapted backport rather than a straight cherry-pick.

Thomas Karpiniec (2):
  net: stmmac: propagate platform mac_finish errors
  net: stmmac: qcom-ethqos: advertise supported SerDes interfaces

 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 22 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  4 ++--
 2 files changed, 24 insertions(+), 2 deletions(-)


base-commit: ceac0de741bfb47ca255eee075257b3bb31f0651
-- 
2.50.1 (Apple Git-155)
