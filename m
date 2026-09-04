Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023096.outbound.protection.outlook.com [52.101.83.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EA4FDE4A;
	Fri,  4 Sep 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540184; cv=fail; b=my38Z/+UXb92qwlal3xYQZrbmsWADgP04yyyO/NUJSu+UZBkCB/0LjZ9xhJKx/6IwqI2HQPc8ptER71bcxS43Q969BCV+9LoPuTphGQJIbg80RtH/qK16FOlHE84Um3f2CtRLhXHADkScRguoH+SNZawZTqq3sOJ6/FsBoIb+Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540184; c=relaxed/simple;
	bh=JXfA3tGiRCAt3BhKxZqnqTqf0NwH6C13PzLmgFFDVq4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Oth/fPnHhkSoOp3d00dUxcMecKpZwVloje39/BpGaP3JsFZeDlpXDCJmhYwr+uRB+QmwzARJ9VKne6ZNqTSSLsi6eXfobD89jlwsEIrQPSecPssvc3GQXFOjS1KHgLdzhCIPF8D1aj23n3Pv1AIAp5W8Qt2/Sge3fBJqb6aZdD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=IkL/bWjR; arc=fail smtp.client-ip=52.101.83.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="IkL/bWjR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Maiftpwgtgy5zlkjvbfPy7ekuZBTuOMXjhZcw9opqAt+tTBV+mTAOkoNsmqV+PrrBiGqGqU96zTyNr64+RNx0D6wxkG8Sy4H+cR3shNcFwhkmxwwx0IvndhNt1x5G9uy3DDm0JVc6aLF6W+tF2Gub4fPVrt87A7I5FUvw+c6FfTy+TuhMAzw8v5zbuQBGqoSjoTrP8IRXet65WvWmcdqANFmR2FRKYCQ8zUTiaRf2iYVrPdZ+qVZp/JAVtQhPW/33GgjAHIVKolk/Ta99FM/eMY+yjJvxlNN3QN9M3oyDHmH8fitTOpOcbyh82/Voa0IWQnqV/F85XzgXdwc9LWSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCJ5UZ08r7XMHW0VajbGt7Hebr0OEmLz15PKF5kqu0M=;
 b=TPws879/dDiDvFGSLTU0NiQT/1sHOfH2/z1+rLEaEtnJ4x8Fs5ZTbBDexesIsvYt/0HnsfVv27hfTlW7Bzu0RdJfvZnMtGvfHQ37tl7JCqFuWSg5CnRp8HaRTE3zkidedrz2f9+n10BFTV8L0DObC9QOwQzP3gZro4DOSNLApvyV/4P+SK6JKm94hR9B2Vxsc8ajDUjmJIgmatbLNFwU9+ydO1PRehf5cSlA/l/MufJhX56OeWi+rweqWjuzp4zFgqusZ0BllC+D6E5xfBuDunvfnpdZcQEnI4QBFNZ6dqcxyktMmzqWWAzlocWaozxejl1YeC38+4V7wHx91Brqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCJ5UZ08r7XMHW0VajbGt7Hebr0OEmLz15PKF5kqu0M=;
 b=IkL/bWjRxhtfyfkf2fMGb/AOA5gTnfEx8c5WZnqClwjyq0mPZSM0PoOQR+iMwhESP66StP0xG4uazo46JbxZgf05FrGKbhEqYxGJ7PU1lFdC5Z6wgQ9GIxHjGsSFlv4FN28CYcjutY8f9JRUS8uSYepw/9JYl9gyTXiyKXWOnAB+MfIUo4m6JJsvBhPwWPQJOWX+aKKaHgC0iiK/tjGzpqwL2/2HA41kJpsAAEn7gKk+w8rMrrfWIOWKAstz2GEJgXJ1MWDl0T6sL9ENBZ2qRdppMJvyM1BAea07c9giQvbu0e7tl4HgeKiWSyDGBxET8eQGF1r85iJCw4RDaPIUBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:46::8) by
 GV4P192MB3117.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:2bc::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Fri, 4 Sep 2026 16:42:56 +0000
Received: from PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8209:40a:b436:bb07]) by PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 ([fe80::8209:40a:b436:bb07%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 16:42:55 +0000
From: Chris Gellermann <christian.gellermann@codasip.com>
To: bongsu.jeon@samsung.com,
	david@ixit.cz,
	netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chris Gellermann <christian.gellermann@codasip.com>
Subject: [PATCH] nfc: virtual_ncidev: Add missing ioctl compat handler
Date: Fri,  4 Sep 2026 18:42:52 +0200
Message-ID: <20260904164252.18351-1-christian.gellermann@codasip.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::11) To PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:46::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0796:EE_|GV4P192MB3117:EE_
X-MS-Office365-Filtering-Correlation-Id: fc644baa-644e-46af-40f8-08df0aa39208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|10070799003|366016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	3/RgtgmXNBJP4ekFLGsrdoYpvfnXYb/doYi9V/nQcI88GlWpgEfk3Ovyrx+L5Ii5e0K5sdq7SHqydryq4DEexvDziy3eqgNrd8Qv7w4klTAtbnEk0Yt2B6uQ8ZHnybgndpe+CshhqQFSyU50LTF17sEmey1Buvm5fDzoOIooWz1tQEffcK4arDh1vSi7ofTea8VE+7MKnfFzJwArHoUCcaRjXV9jvReK2xbofMYmoVevz0Tg5ZioB+XmyuUp63S6eYu9iSQVH7e9hUTbU1Ied6Nl7hHOBnh/aCTqkz8PNeGBIKot1Ma0CcaxhQrxwn/kIs+WJHopDPzZXyhtJuIX2I21JZf/J6mRAUj0CPTy1haycQQSVbZXlGhS5Xs6vtmEiJn0CtkkkLiud4bunmbF7iHgcDkQLQ9WWCl2K/utigqX37o696+bQb3Sx8F7OfezPpjrtz6z16D9QVjScwOJNIhShf1umAInoje0XgLHuIdFJQsWEUhKJwyhNTTh6i+qpFagTAgEl+003Pr83SlqEqLN3cs5rL83G77bEZYU7Vb1sCWnPUIqH2Ra9MTLR8cEDY2vGs8leKB3TUqJQNSxgVd9UtU0yuC9CCM8H2CKwoc5uqC3wvlVZ6C3lddc/7SqZ0FcJV3Kq9bfBAwegYqyRNjyRoEfG0iFI4NrxcrZubk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0796.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okMbjHWkMzmuNiUONvUcFEYyV7SJwfC1YlaBm0aLthIq3gUk76zMQ5FXg1dh?=
 =?us-ascii?Q?VGTUbO57JNTjuvtJEr9/SPY4Ffgi9a5BwIASyWCS05eKiKh1O3u1QsD5FBoR?=
 =?us-ascii?Q?eVZA456z7aGaVkA2YgvsBQ/tHZpBX2QeuYuRccG6cODQnC+LW+CXzE05fGfh?=
 =?us-ascii?Q?/o1kwyKQfCDQ9bajF1k89eyb12U1B+zDdjNacso7b/PLdZjBUVKLueCDHGVk?=
 =?us-ascii?Q?0BD0OUzpvX3Etu6w/WjVUEtyaPUY61FRJgZmePBChAAEKJe3Vh3iOBd542ie?=
 =?us-ascii?Q?muuiBNW+O1c8G2NX21SCjeg3UrkttmG+CcGgGUZaSrevUdcCCWq6e8o9KEqq?=
 =?us-ascii?Q?AbmOvAEde+Qka801nzhslL1mkUxACWOo0sWNFH3qKtb0Cf8xfpMreTbNXGgM?=
 =?us-ascii?Q?V5g8IS6qVG7iUpR3cukMiq56SNX+Q3ls4wZkpmvXr0yFRIiBsG/KcUdYx8Oq?=
 =?us-ascii?Q?qlzyJ1BJYCJAU9C7Dto6NylGeH4tKxN68X8OhVFng1oSXfBidYkQg8haCRX5?=
 =?us-ascii?Q?xFrnwXfQjd59vCEZQzO5xdkEgBnmOccGgPrK2YQVZiSogeqnkkGKFpo4O/E0?=
 =?us-ascii?Q?f4/BciIrMMoiRiFYVIeCU21txHkr0sy50naFVBtABR9mP9c8rWNIz/HssiHa?=
 =?us-ascii?Q?TZXG+vXDLux4KYK/ZuiwAvx42nE+BhmGeDdt+DX706E/AUe7Qs7ezC+DY95o?=
 =?us-ascii?Q?Gj0Rkvx5bdyG2Y9bPVaP8A/SlxLe6RyG4i95KCK6PV22veaxU/CCc2I9P9Iy?=
 =?us-ascii?Q?uM0MFUWB4w2TPL4sNfYTUlxIRaOQeVsDP/k+FpbJH18v3iEo8krS8EzqneSc?=
 =?us-ascii?Q?Pf9OPBQqCzb1PhT437oOTo2idPY5WBnIlcSxErFjUqT4/jyXdKTcXIb5W2Xj?=
 =?us-ascii?Q?HJCir945g48XQo6izfFrYCjwmAeiDlVwObtqDo4wwwPA2q+Z+d0sQROoE1C7?=
 =?us-ascii?Q?vmDt30DdyRpMtvvmCdN3ny7vZWABl1xYuppm/djxRFTsAS0go30aCvErqPLf?=
 =?us-ascii?Q?Gmz9H5KB3JuL/4pDEO6emO/NwY59tgE6qnJi9VnnxGYtVCg3dOFv8SeMDMHt?=
 =?us-ascii?Q?ki6Zs5fc7cZSi3s+xATqM2LmvN0xCEiUodzlVCyTU8VXISJcd+o9Qvscc/JB?=
 =?us-ascii?Q?s0kAnWQ1PrXLsVbzrmpdgBVDY7sm9FQP0Oi1yxZFxKxJOxdD80EUdmWIZ8pG?=
 =?us-ascii?Q?uqup1exd0o0ETijyZqZgfKknm9+I2RIRstji8vI5CFO/oIo+c05xzQHwSKGI?=
 =?us-ascii?Q?wPCkxUdDFFuvSO+aG75ZLcrwxFw1CxksHRzacmYOHY2n8Sigs/cMu0UzraB+?=
 =?us-ascii?Q?Z5HqrFqlNRFmCMyIoOnnVWrZN0DT5faBgZ1PZKM3QwYh29Dc1Xh1CUaygfyw?=
 =?us-ascii?Q?YG9fnRwbux2oikStLYqaWXlpl5beXOwBlfKxeb76zPn7A5xvjn9klFsWqn4i?=
 =?us-ascii?Q?PDntee+3twCpDuOBMOMWWQyQu380SZL801lUOHB9MSm8t9DGI9MV9p8tPP3d?=
 =?us-ascii?Q?TGsx8Lvl70CN+3KdpxPCA4CGE+ALsu4a3/ElQyS/8O5x8pQaWG7Z3l/czV+D?=
 =?us-ascii?Q?EYbNpvRK4E8segGoD/cyMuq6gzGvfmuIgXz5YwRCFJKs47x07oSCpegVWZWD?=
 =?us-ascii?Q?oLY2vYMs750Tg/GQoCxL1NRRGN/YZZ8j7H8EwyY7093AAoK3/1nk4w7ubgW8?=
 =?us-ascii?Q?i5ZkObTSpwIpjcrvZoaUh4uMgQYT+HeVtCm2RY0X4q5cA+JvohHZEGKgy/J9?=
 =?us-ascii?Q?u3uo05QqdcY+L5u6gZmIyX2q0J6uVP8yWzQFy6oHpzAg8mws3di+WgnVXNX5?=
X-MS-Exchange-AntiSpam-MessageData-1:
	xe/4T8Y2Pq8iIzPnmDPT5bFWj1k9bOdEJv4aUQ26FsiviqHxOm0K/kO1
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc644baa-644e-46af-40f8-08df0aa39208
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0796.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:42:55.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GexBjZSLqt4OOV6e5xQg0+iIMVRnEDxfwvfDR/6wir/OKlLG/e6LPmDNy2D59+IgtkI2ESkS2X81eTYrWe7L+PAVLZnIF4eTn1Cn0cJMvMxYwYQe3o4tsZioMhFPVCgX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P192MB3117

The compat handler for ioctls to the virtual nci device is missing. So,
nci-specific ioctls of a compat task return with -1 and errno set to
ENOTTY. Add a handler.

The handling of an ioctl() call of a compat task to get the index of
virtual nci device (IOCTL_GET_NCIDEV_IDX) lands in the default case of
the ioctl compat handler (see fs/ioctl.c):

COMPAT_SYSCALL_DEFINE3(ioctl, ...)
{
	...
	default:
       		error = do_vfs_ioctl(fd_file(f), fd, cmd, ...);
		if (error != -ENOIOCTLCMD)
			break;

		if (fd_file(f)->f_op->compat_ioctl)
			error = fd_file(f)->f_op->compat_ioctl(fd_file(f), cmd, arg);
		if (error == -ENOIOCTLCMD)
			error = -ENOTTY;
	...
}

There, do_vfs_ioctl() returns -ENOIOCTLCMD and compat_ioctl is not
set for virtual_ncidev_fops, i.e. f_op->compat_ioctl == NULL. So, the
ioctl() syscall returns with -1 and errno set to ENOTTY to the compat
task.

To fix this, use the compat_ptr_ioctl helper for compat handling here.
It shall be used for ioctls that "either ignore the argument or pass a
pointer to a compatible data type". The driver's sole ioctl takes a user
void pointer and copies nfc_dev->idx to it, a 4-byte integer across all
ABIs.

This issue has been found by running the nci_dev kernel selftest as
rv64 binary on top of a CHERI kernel, where the ioctl() ends up in
the ioctl compat handler, similar to a 32-bit application on top of a
64-bit kernel.

Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")
Signed-off-by: Chris Gellermann <christian.gellermann@codasip.com>
---
 drivers/nfc/virtual_ncidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 8eeb447ac96e..e51c647b27eb 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -195,7 +195,8 @@ static const struct file_operations virtual_ncidev_fops = {
 	.write = virtual_ncidev_write,
 	.open = virtual_ncidev_open,
 	.release = virtual_ncidev_close,
-	.unlocked_ioctl = virtual_ncidev_ioctl
+	.unlocked_ioctl = virtual_ncidev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 static struct miscdevice miscdev = {
-- 
2.47.3

