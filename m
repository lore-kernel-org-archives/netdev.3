Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680464;
	b=CoSNs5sn9x5npX5o+5NtEby7VshRYYT2CkEGFsIGuFOVPMVzxgZRnZb3ejKcTX8M42qF
	 mKlPXQ5RmyyS6/aBIsv4iiYYyh3QDMbhmMruLq1Lldv4o1joASeqCpwK/PrO+N6rIlyqN
	 +wf5dlp98KYA5tG1KKFrgjMhOwj5IdzcWl2R0Nigs65lxRSPrK6h0QtaF4q9Z9DIMy3Oe
	 fzjSv0T3XdgaS5J/cId7fMGK+RFWykYTLe3Ee4i869pfrza5dGxWY3910gHFU4NaNejAb
	 hdstD2IyDfnNswi7Bxl91+jb6EJiST8dq/P69Wq+HndequVYjjtaUFI1PVr8Mwqj/wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680464;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=fAr2ze+GnzYp76pjsyO3KRLM40bM3z0iFttGuo43GmE=;
	b=UGjVMbdF/iJdYWAiR0k41GR9e7HHTL+dK3mEpgi2wqGc1KZVeDOilPDdODMEHXE90dzr
	 mRooPNx2+KRBf5w5b/fBR7stg4GiBdZlNpz2X0JDLoPf4shsC6z9Q1FTa3B62wCfV+WUn
	 PUSYwAkygKZGQsrPNH51sTE2WO8Sb5B4+9RBd41gl2/Fnb6vPNa13Sht+3dy9bM2S3Jyp
	 JidxCtOr9R0jBYszh3RohjKNFMSaoUgzz+GKgQTBV/ZlhHaLTPxZ6WMcT9DE3b1rVMSal
	 XzZ5FhY77TS+5OGgXOrADarucAB80Wlp6FmMNAy5LKyvusc0g/CwSTYHfCpRIgz3ZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GAZ05K3+;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137A606A31F;
	Thu, 22 Oct 2026 14:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2137A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GAZ05K3+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fA
	r2ze+GnzYp76pjsyO3KRLM40bM3z0iFttGuo43GmE=; b=GAZ05K3+fPSFHLOebs
	7D1F2E9NQKuN0ve4obwPx1pTN2RihnzVoDZuImgmxUAgvpq+G5wgPRNsIYKPwYF1
	T3G4kxbUQ/58CFcIsSIbQ36LgiJUsrSL8MoL3d0aGHPx/Dpcikgwy2YDtknZyycX
	iW2jSGJvisOmlRiZBXEvEi5EA=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3n2PdIdpq_ITKBg--.59388S2;
	Thu, 22 Oct 2026 22:46:54 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [BUG] net/sched: act_csum can checksum beyond a short IPv6 jumbogram skb
Date: Thu, 22 Oct 2026 14:46:53 +0000
Message-Id: <20261022144653.60550-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3n2PdIdpq_ITKBg--.59388S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4kArykWF18CrWUZFWUJwb_yoW5Jr1xpF
	9Yv3WavF47Kr4qqwnrKFW8Xws8Zwn3G3yDX34DXry8ArZI9w1jy3yft3yF9FykXr9YgrWS
	ya10v3WxJrW8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5a93UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC0B-Q3mraId-ZJgAA3w

Hello,

An unprivileged process with namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW installs a csum action for UDP-Lite and sends a 300-byte IPv6 frame with a Jumbo Payload value of 0xffffffca and UDP-Lite coverage longer than the bytes present. The jumbo-length addition wraps the pull-length check, while the later checksum path still uses the unwrapped length.

HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
source version: Linux 7.3.0, local master
compiler:       gcc 11.4.0, GNU ld 2.38

console output:
https://gist.githubusercontent.com/shaos26/6522612a4cac2b4db3e4cfc32ec8ea8f/raw/5b12fad1d38c90b7a8214e02bffeb7bfd0994ebe/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/6522612a4cac2b4db3e4cfc32ec8ea8f/raw/f6506700a588fd394fdd662c4bd91115e0cb8c3b/kernel-config.txt
reproducer sources:
https://gist.githubusercontent.com/shaos26/ef3fd748f2329565eca96a4f4e3b2c85/raw/7694fd571c683bb1f98793979b7bf2fe09559bd4/poc.c
https://gist.githubusercontent.com/shaos26/ef3fd748f2329565eca96a4f4e3b2c85/raw/200625ab70731666abbb27f0e233a42626ac7c58/run-unpriv.c
https://gist.githubusercontent.com/shaos26/ef3fd748f2329565eca96a4f4e3b2c85/raw/7c17996d150eb55421fd88cf62b4a71b8ba14207/seed-secret.c

Build the tested kernel with the attached configuration and boot a disposable QEMU guest. The linked userspace sources seed the skb allocation, drop privileges, enter fresh user and network namespaces, install the action, and capture checksum responses.

Impact and prerequisites:
The checksum oracle consumes 42 bytes beyond the skb's logical data. In two fresh boots, checksum output matched the checksum of a marker seeded by a different initial-namespace UID in 75/512 and 85/512 trials; two wrong-pattern controls had 0/512 matches. This demonstrates that data from a prior root-owned skb allocation can influence output readable by an unprivileged namespace process. The oracle is limited; no arbitrary-address read or privilege escalation is demonstrated.

Validation: Two fresh user/network-namespace positives matched the root-seeded marker checksum in 75/512 and 85/512 trials. Two wrong-pattern controls returned 0/512 matches.

Thanks,

shaos

