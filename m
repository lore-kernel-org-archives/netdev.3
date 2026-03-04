Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57FD35F60C;
	Wed,  4 Mar 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614141; cv=none; b=rJ7cRr7bTT3OIv4j0iCRgHG0vXOtqEEyMr1ROb8MLKT+awJcYY8U1czHATJiIjv5GIXfnizdi38cRaTIrj8UT+zVzeCkTEs+h60BqrQ6iwSWddPp8SBqts28zM11qnx08HPMIhuzckpaaX6e5ozB0WgjYXtNz47h3A+pQCl5RCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614141; c=relaxed/simple;
	bh=jp4zv1IMD+JbEDVrIN4ou0kJ6aerQ/Ci5f1dm53kmTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaV0D0L4ZtcJ9W/XOuL8PJxRA9EGjFe1mnlyyTMJZVVP4qkupNQAVZoHO5J1hv10k4kMwsYAa7sP8OGMLWsmdupxuybt3/7WnUIqBjA16fTOD6YDCMavUMlLUkJWNzHJD37lpxrQyGguRm5CDkStJq3m/Su4I12NycyTVqmxwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vimux.org; spf=none smtp.mailfrom=vimux.org; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vimux.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vimux.org
X-QQ-mid: esmtpgz14t1772614110t8d33eecd
X-QQ-Originating-IP: QVn+zZGyfbROlwYHeNK+bV2TnRksrpPVnTgqAEG9MfE=
Received: from localhost.localdomain ( [119.167.27.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Mar 2026 16:48:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17737399994365302656
From: Jialu Xu <xujialu@vimux.org>
To: linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linusw@kernel.org,
	brgl@kernel.org,
	krzk@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Remove <linux/of_gpio.h>
Date: Wed,  4 Mar 2026 16:47:01 +0800
Message-ID: <7187C401290C256B+20260304084808.440955-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:vimux.org:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OP2legL3v8uLJZI/OiDiop/rYaMhzepUFbeGjTyib26fjcvLpXvWehx3
	/UDALfXuznHeYr8zEvykHkeYgrxdHyFGhBIl6izVL0O8H+RUPnvwB5ohG4vOaNXwK3MqAl6
	WqJV0JR8554/3PaZHkhyPgCrqlR++ELPwttUSFWfGz9o1T/hn7CvgGRwVUHj7FIC730vD0E
	O3B1XVEF+I0uBdGf5td6LH5P4RwHycsUJA76kiNtVsJWPwPOB5Da2WPttHPIRl9DvMdcV72
	wdYVIphfZobGtWonjABks1MynjeQW+JGzt/S8bdTVXqB7WXsdW8yC/x0xKicSB9ev9bRm9e
	ssR+mangP5eb66N0y9bknZp8lgKkRAITuH+44qdnGevMnL9EQMy8o4av6TqN5uTwvJvVA3S
	73Wme66Pgq65HfVLxNei7gNPfZMTnc/NocMywAv0aDsk0+mqLFdy3KqIavKporHmqTKJ3Pn
	ACwtzwxZ0PyhFnWJRiKFjNNpF2azxSqpTOVPd1jH+QJipL9QlfkYID8gcf0rV+JCh99h7fV
	6NBxYm7epR/Gxts+gUoVBP0+tbMYpUx0ieq78USRAc2/xLoA7H5rup1G2nhiv7LY16UU09C
	GebHNBvwX538vKfzD6YrP+7UvgQ4kKvR0DseLfOnmKxoPke3Q1GjVDFUsP91uXKT/2L3B8Q
	x4HV7IeVLqWrzkT64vEizgIJ7aYYInuTX+R3BeFLN9Z0hzZ01fSP8h9kgSdWaCWByzDw/cI
	K7ooPKrN9PveK59exzY02Tmp+OTTjDTyMABz8rb5C+3OjnMFX3JJv2cWQxKiJmvX+NyNKPS
	foBB9OCKiXje9oqDrIjJWVDI1R+qklFe1HTpM9rm6SXTh1MGBsfaeUMfUStOk0R47DK2xLi
	SZz8wfaF/hov/FSCDcrdloKiGm6DjkTAfruLDVPo5avXpZC7mTCJSfv5BihabnjxHYMbSuq
	tZFgxWnAqH4QinWbMEHphKHlBIZScNYvpOnMac5S8iCm/TaI01GL2sXNvZGuHuuZa0Pc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The legacy header <linux/of_gpio.h> exports only one deprecated
function, of_get_named_gpio(). Its last three consumers all reside in
the NFC subsystem. Convert them to the GPIO descriptor API and then
remove the header entirely.

Patchx 1-2 convert the NFC drivers.
Patch 3 removes of_get_named_gpio() and deletes <linux/of_gpio.h> and
also TODO.

