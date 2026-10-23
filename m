Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789410;
	b=vaE2ukwcr4TlfPns4v3O0aQEyZWYvrawGva25Rzzewna7ULedhvqnaAbDZ6vGaD/bz2Q
	 bhJ1dQFC24JWB3g+RcPF/XXuRDx9VqvxBw+FiDt+fUQ4iIJ2pGWUeg9cbjVycpYdRtYdB
	 aTWaa/5PlnN3jwHwMcWLyGyYNt1IV1CGtdE+c/TG2ZDejwJS4g4lV8yyzYOG2agogc+p9
	 PzEEAkjbUmmLvtnf22KM3zLb28hC03gqu6oZ/7LfbBqhaaeZCn3AB/QJxxKF7nBdONUzF
	 fFItKuawIOZGlFV9i1qvjYvrwPDV+kRw/7s6gHLlCN4pgNtH7bEEXSFyVZ0rkozALgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789410;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AInmA40ZqY/lMrocMvl4Jq6XnvgXz9DNdeesj0ndxFQ=;
	b=yavSu1birRDI/xp8/uFEKT+s9w0/hQ/CGmb5bIrygz3t6VG2Q5FIBFGJU26FWFgJQ1rg
	 UpJD+4mgODRpgP5I4ArnNzXoYlXx45bQXorNUMcL4gRIGTzZefmehXMt2p8tQJ5g6kSpA
	 MS7ljNGjEgh+shbB5ch7ZMt2P6FsJNHj+Qk12ThU3A9rwppammtTafXqWRVO5UgdT6uCv
	 idPa7zejM0IX32Oh7mTgBFGBPBJWWiOKUfqYvjd3zUAlgVW3WueZcB5L1HiduEy/uRKy6
	 fwL7NODuxMbOQJIcdwwQFlFii60/QbqBbQaDl/OC3xKOZrblgMmTSbf32NapYAjyMcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=pf19SbFB;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C610606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 21:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C610606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=pf19SbFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792789404;
	bh=AInmA40ZqY/lMrocMvl4Jq6XnvgXz9DNdeesj0ndxFQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=pf19SbFBKUAtFSs91VC4qNbpR02Jg1bkxK8aclT5P00bm5SWGx3e6uZMIQNLfOCDE
	 y5IlHBwh1pO0NLgHQGqAxnAMuGCIQpAakQKvc+UG1erX04ta0stmqmEjEcN8UTFwgr
	 Tyrv7G0rGfz336ae1W5hXV5zpLmWtnJvofoJEEhY=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id D62EE9E; Sat, 24 Oct 2026 05:03:22 +0800
X-QQ-mid: xmsmtpt1792789402tw7pjqcnd
Message-ID: <tencent_A40150C474B4D2DDBAEA56D8B20F03130506@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLTqtZTgLlM/1VbUnaBIrZ7YXjuHU7+eMQFz5ruNtoeTx7synsNG
	 OsVWSdlDi3pKZPyzM6/YkCc0ixGn8gP20KAK9dfcSRPpUobwXo9syG13pOS6osvJlsDYbFWWfljI
	 ai0NqQuOo40HFBVWSRMkx92P0/ECGQNN6eU8iT8sKgIMEjV7+RwuPlP/Wp/eFJuEz72ju88xgkhg
	 LuzFIc1w/D82374lZ4Z5Uh7Fxo2NNUlpzSnGDTQPUof7qilcKUqtWpAHh7b+d5z8b/E8xGWFRMSv
	 7wLBahdYN/9y6RGoEeKasHCxOzZOGoIURkwLsan5hp58IzWqXrO553O0EH8hTdK6qnFHuWwulztp
	 UkUQilEV8vAM/LYByf79m1zJr8go/YU/eCs+HLE0ax40gGCJIBN51oEorOAW/1gwkAcG/38If0nj
	 G9LFXAQZqmN5YDF5GXfWFM3hiHHAUDBYvHjjNypsTDSLoeEA91ej+or3tO/Urk4vlGIV5XPFUJbf
	 k6XvYzB80p2MsX+DkHAp1JmYDei2CRhb9+IOOA2n2vSqxcBqLTt3DqcDVyEQq7UVQ6BefEXcOIQp
	 Q+e7pnW8/m2C29Fecepm5gvizjSwehWL2B5zEqxXNHWozxtswYwl63oQe5gnIU1FBaI2uSMuqlzn
	 1UhxVrhQ/Qwqmpg+itM5dp+dvB+0x3yCotsUUq3P373NoRVV4DdrMuXY8EfSD77SrEk7frBdU9mK
	 WcyE7fdGsxSpHaUn8I7PJ4fJLS5ljNE8TP1Y0IeipibyyOArVNnVVEXsvx9rBfyGhlQfS2QWWR9Q
	 m3Wot2zwfq1MSAtWkAaCFWb1xOPvrFRemhvbWFg2i9OGmEaIs3ZSJRRbWbXLha37EBG5xKHblR3k
	 I8ZIeUDmEpSUVAsSogCKO/PRt1a/5ssJMuxpEtnk6aInlKKx5GBLUslxQbvlrcMeLNmXd2k9t3si
	 biMjyPj+uJ0WUKCa20Tsz1zt4TnfJfbYN3qze+2ljRigbbpAE7fHpO62K3szf0WnL6iQHBSRuuRN
	 dkB+mMLssQT400mVay9yppBmxAJsk=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: dsa: mxl862xx: bound FDB dump walk and validate BRIDGE_ALLOC ids
Date: Sat, 24 Oct 2026 05:03:22 +0800
X-OQ-MSGID: <20261023210322.42971-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179278829990.3327.14694215720214654641@kernel.org>
References: <179278829990.3327.14694215720214654641@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Hi,

Same context as the v1 thread, replying here for the v2 series:

Discovery: manual code inspection, while auditing this driver's
handling of device-controlled responses (the MAC table walk and the
BRIDGE_ALLOC reply).

Trigger status: the unbounded-walk mechanism was reproduced in-kernel
-- a self-contained module carrying the verbatim loop shape of
mxl862xx_port_fdb_dump() (device transport stubbed) built against the
official Ubuntu 6.8.0-71 headers and run under QEMU (TCG, unmodified
official vmlinuz) never terminated on its own (100M iterations logged;
a real table holds 4-16k entries). The reproduction is automated in
Docker and needs no special hardware. I do not have access to mxl862xx
hardware, so this exercises the driver-side loop logic, not a real
device.

The BRIDGE_ALLOC validation is logic-level: the driver consumed the
firmware-supplied id with only a transport status check, so the
reserved id 0 (which doubles as the "not allocated" sentinel and the
CPU-port bridge) was accepted verbatim. Whether compliant firmware can
be made to return such values is unknown without hardware; the checks
guard against firmware that breaks the API.

The v2 diffs themselves are small and mechanical and have not been
compile-tested against a full kernel tree (no hardware here); the
reproduction module compiles and runs on the official kernel.

Thanks,
Zhang Hewei

