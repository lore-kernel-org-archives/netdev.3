Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE737D11C;
	Fri, 30 Jan 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794642; cv=none; b=dJACF3yOj6Vhpk2Jxg7aPW8glionnsn5gfj/pXgnR6DGlmAUtDSfQY5lcWCnirQLIhz29oZmK0ycL+GzdXZeZqacCS87rj0PEWVVgtfOHvIaHWGaoaognsrUQXoNp9wMSv+hZMcgjZt7vLl9apLOXX6ysN43lF91D+Z2AT4xi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794642; c=relaxed/simple;
	bh=LA/JT24Y3WjoSTmwnPRQMbf92mtqC/hdHWEqgCNVRWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSydj4eNkFKJsiN7jdGY/pUF1jxColLKph7pEfO/KpQaHZ+Mz6vj4e/Mt0ksKyS/55AIA6Jq/uXpDIEMR3rkRDxIdjc7t/OeQVMpVCkCjQ35x+B5t4uU3YtbNNk38EaTdheALNjM9i+OkPrRzO1Ag2BLIgGh+7otxseNOIIo8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GAkgessB; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GAkgessB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794640; x=1801330640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HJNJQ5JEVCdL0Nrz7O4LdClGsPLkSanD1Ydscs5SXNk=;
  b=GAkgessB3NEuS9Tfyl3Q+xhkx/ZiQbheopHrXh1/HOPrvh0ideSMoetk
   k/N8o0wsZHRXMUMnVm5Kp6rCtZsG66ajDba01ovk1XQZatYiycHQ64Gbu
   QeeQbHqA42CcYmEOz8dfLt02fPijdME0aU6ipRF0Jo8+1DjFFFwKBrkmk
   7bWjBHMu3QV/+TWN7FEaUXVzzSKN7nGIopAetbTowkQZYHi7hoM9rQZIx
   W0gbRXbnkRdqS3c8f0aGftuK9zRA6DUsNCmnMmp21geGtiRiGrhgGIz0l
   RIY7jSm+lMbu+yvP36fA7pCLgE6Q89eoS1W2eD6LZ6A7SFc4uBDAufgOI
   g==;
X-CSE-ConnectionGUID: bkJYHQ6XTsmB3iW2GSQ88Q==
X-CSE-MsgGUID: 2vR+Sjq9R5ypDXY1bQKwXg==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11933846"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:20150]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.147:2525] with esmtp (Farcaster)
 id 49fe7975-cc0b-423a-892a-9cc7c84502b6; Fri, 30 Jan 2026 17:37:17 +0000 (UTC)
X-Farcaster-Flow-ID: 49fe7975-cc0b-423a-892a-9cc7c84502b6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:17 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:14 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 1/7] ptp: vmclock: add vm generation counter
Date: Fri, 30 Jan 2026 17:36:00 +0000
Message-ID: <20260130173704.12575-2-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
References: <20260130173704.12575-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Babis Chalios <bchalios@amazon.es>

Similar to live migration, loading a VM from some saved state (aka
snapshot) is also an event that calls for clock adjustments in the
guest. However, guests might want to take more actions as a response to
such events, e.g. as discarding UUIDs, resetting network connections,
reseeding entropy pools, etc. These are actions that guests don't
typically take during live migration, so add a new field in the
vmclock_abi called vm_generation_counter which informs the guest about
such events.

Hypervisor advertises support for vm_generation_counter through the
VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT flag. Users need to check the
presence of this bit in vmclock_abi flags field before using this flag.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Takahiro Itazur <itazur@amazon.com>
---
 include/uapi/linux/vmclock-abi.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmclock-abi.h
index 2d99b29ac..937fe00e4 100644
--- a/include/uapi/linux/vmclock-abi.h
+++ b/include/uapi/linux/vmclock-abi.h
@@ -115,6 +115,12 @@ struct vmclock_abi {
 	 * bit again after the update, using the about-to-be-valid fields.
 	 */
 #define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
+	/*
+	 * If the VM_GEN_COUNTER_PRESENT flag is set, the hypervisor will
+	 * bump the vm_generation_counter field every time the guest is
+	 * loaded from some save state (restored from a snapshot).
+	 */
+#define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT     (1 << 8)
 
 	__u8 pad[2];
 	__u8 clock_status;
@@ -177,6 +183,15 @@ struct vmclock_abi {
 	__le64 time_frac_sec;		/* Units of 1/2^64 of a second */
 	__le64 time_esterror_nanosec;
 	__le64 time_maxerror_nanosec;
+
+	/*
+	 * This field changes to another non-repeating value when the guest
+	 * has been loaded from a snapshot. In addition to handling a
+	 * disruption in time (which will also be signalled through the
+	 * disruption_marker field), a guest may wish to discard UUIDs,
+	 * reset network connections, reseed entropy, etc.
+	 */
+	__le64 vm_generation_counter;
 };
 
 #endif /*  __VMCLOCK_ABI_H__ */
-- 
2.50.1

