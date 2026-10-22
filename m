Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660053;
	b=mdOHoUgLqq3s76PGiJ64oUECtbq7iCRK4F01Tstz3dOU8V8L+96hgxABDgpFerqs2O81
	 XAC49XjMEpsjrHMZMeogjnncFsKPYJyGXa7T+TtR3tAsP1+Oj/AbBTHpolhTOg59dl3Ec
	 2zZp9rz49oUlsXLS2U8K2byNbLR4qFb78EO425p5TeRfqiT1NcdpwuI8MFMetAsjaOG8L
	 Hr7JSkUAreL5pnMpjhW2r12UwswoUsd8koHXvWa4oimpZ3Kp/GSM68nZCJkuFG3VQ7AiC
	 qaVnVkolrhFpxUqeDR331tiTIl3amnsjaC6zJX3uW/E+wOApbnpKnsrAK8+SBpeJUng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9URtOwr/J7TkzlGgRbYmOknzNQNn+Yi2oYcy4B3bLaI=;
	b=ZzCOuAjCpqv08CGF+zpoLaNt7bB93y4/CDFXjYYXuXS7OPAx//SPqn2GPq3I5MVbRe/u
	 4cf2SZsMgjRnd2Lf6UguXfdo3txgs2/yAT7+LYnefFywG2LSe4luplB2iCA93AC7mxijB
	 F7yqk4lBiGZFoE8EEIZxTe+YrE11bqN4I01MB4ugnuEm2o0X3dLAxgZmdO9nGRW0fF6My
	 hk/qwS5Q4qXOLMT7a/iYqL5rWnzwHCEsfKAzvUqnDEOY+Fhow9uP7I7R52tYC8tRahar8
	 aPb9XO1ylET9yE85GiH8fWnGBY9w7V62mOjiFWDa6qcE3uhn+kUFQWsLlKuzGXIwSJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVZKXgHD;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9B606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20E9B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVZKXgHD
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1438d9363fbso575264c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660052; x=1793264852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9URtOwr/J7TkzlGgRbYmOknzNQNn+Yi2oYcy4B3bLaI=;
        b=HVZKXgHDanhShJw8E0d4K0w2QBiQl9RZpmkaE7rsFczVEtf9PEZWSAU8H7xlKk/bCI
         Y/H3DcMjWnGeNo9exCA77hEiGIqgV1+Tv7vS09h9WlWiSXoq4Id4z8VIUn/IttRTk+5W
         ZjKKyzsFnrFK0TVXtXlpuwr7QHLkMrbDfTo1fcFvApSf+xqBkOD9IbTNgF0ifBFq64YZ
         fVmFJ/Lfe4Fh7HL9tcPQ3bwmdyaEooLhB8O3d3otW64v4Wzj93AJ9OE6Z5F+v7jscfAY
         pXRGWjOB9VbCdSvhkekbX85xNroMDOjw+Tefs5SrqMhGSekFBqLslmeWArJKKFchRT3h
         efZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660052; x=1793264852;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9URtOwr/J7TkzlGgRbYmOknzNQNn+Yi2oYcy4B3bLaI=;
        b=2sFM6OawzdocgcHpuTAudLR8OH5mUTOhGFy+eFsqHC2nDIRoWPsY4gLBnLFi33wY3r
         mifhSiT3ZacvFsnyGldkL4GWHyJ+nkVEbl3AfcG5JwDJAXoN+LOS5t7A1zErs7oICbE/
         63G3u8YnpcaQfFYxdSvr24k8xZoTio9VX0uhrODe/JrfDRy5LMELRUaknyLQJW1Z+4tD
         yaMa7NW0XR2UUWD0UnsW64lloH6mMvl0W6Ecqfl2unKO/HbZ3qQEmjI9MLqQrpd+Vrxq
         pKUqI3c/U11mA47tsUkZD7ilZyYpVc4nd1nwTU4n3xzFcJKdObM2OxEtnCcJK6QUcqnK
         v0nQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRA5wL3Hh4TQH+EqDcqh0bdRFpveRunCQ5sdtB9tjgqmjceU8rlCCM2LdNUn69RSFW+lgRZxA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrJ+laZ5x/xeg110ffJwPn17kxwE787K8P95QE9fIOUzgN+qgL
	bCNHW9FA/WiKOCDIEqzD9gWESlEhRrLMWb+e6Cy8QUvUhaHvCSbkQu+M
X-Gm-Gg: AYBFou2ewz5Xylsrnm/eVgeo4IhpEL093+N/OA8V2wJvrJTsoJ/oNpM64K7oc33pCiU
	lTsWVORQmP3J+wFSzjFTX2NKcFJKb4pNHnxyAHi3saOyY4+F2mKq6oAZA3l2lQ8qn0oxGemKhuH
	ypLcFxu5JFqp1soCHdYPU7fGXMhG/5UOCcNGe2xdrJ3JyRgd+UH0N7ZXSGuddCTvVGSLRvyq2s+
	GORqRhKf5J7qEjrxOQUG1eKdnHx3DqsfTtF1GMI6+tC/RdNzsjZMTqbkTjBowmcqYEMvVAIboJS
	93NtDkc5mJyDXX6GUyWI2Cj2wgh8C2Q1W6vXY3DGgNffyI42/H9xd++YrYdmSzrMlS7/GycX4dr
	nBtespiSbvH8vPqMRJaEzs22Wax1amwdQDakvkjhe/NA4Gs1aspXNFjARTT61lQbeZEe8WsbtB0
	B1WFP7jKZtRu4jFHJWfYLQ7PObPLuf3ejnX+kx7EN8svXjqefqQyFTeeozmdLR9GBdGXv8cmXVe
	l17IKP2qzDMwtdjgdfYcrAwTJ7soA7Zd5eE0VZQvGvQawlQk0GkAtFvwK5fUS0MVEdgWM9PKHII
	oTuT3IVWn+Ulp5+f6RY=
X-Received: by 2002:a05:701b:280a:b0:14e:61bb:ec3d with SMTP id a92af1059eb24-192f03cb940mr2225519c88.16.1792660052045;
        Thu, 22 Oct 2026 02:07:32 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-190e29381d9sm11175412c88.18.2026.10.22.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:07:31 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: failed offload leaks busy hwdoms and TX refs
Date: Thu, 22 Oct 2026 02:07:23 -0700
Message-Id: <20261022090723.3644079-1-teel4res@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

br_add_if() can fail after a switchdev bridge port has partially
offloaded.  For a bond over DSA user ports whose LAG members report
different switch IDs, the first member successfully reserves a
busy_hwdoms bit and increments the tx-forward-offload static key.  The
second member returns -EBUSY, which aborts the upper-device link and
eventually frees the new net_bridge_port.

The br_add_if() error unwind does not call nbp_switchdev_del() for this
partially offloaded port.  The reserved domain and TX static-key
reference remain with no bridge port owner.  Repeated failures consume
BR_HWDOM_MAX domains globally for that bridge.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  before attach:        busy_hwdoms=0x0, key count=0
  after one failure:    busy_hwdoms=0x2, key count=1
  after three failures: busy_hwdoms=0xe, key count=3

After every failed RTM_SETLINK, bond0 had no bridge port and
/sys/class/net/bond0/brport did not exist.  The bridge port list had no
owner for the reserved bits.

The target bridge and DSA code were unchanged.  Because the VM has no
physical DSA driver, an in-tree dsa_loop build was exposed as an
external test module and a second switch ID was supplied through the
normal DSA identity objects.  The reproduced path was:

  br_add_if -> NETDEV_CHANGEUPPER
    -> dsa_user_lag_changeupper
    -> dsa_port_lag_join
    -> dsa_port_bridge_join
    -> switchdev_bridge_port_offload

The failed br_add_if() unwind must fully undo partial bridge switchdev
offload before the port is destroyed.

Candidate BR-030 is a distinct packet-suppression bug caused by a
self-match and hwdom 0; it is not this resource leak.

The module sources, harness, and full logs are available on request.

This was found with AI-assisted source analysis and fuzzing; the exact
resource progression was reproduced in QEMU.

Thanks,
Cheng Yongkang
