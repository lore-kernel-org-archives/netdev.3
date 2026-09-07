Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0445A284
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774915; cv=none; b=Tvdoxz4jvaDfPaHkfX+WN4oC2YhkmqzvJSFEJ3EphI2mlgDEzRmCiTlAjpykQpvyF+iFTnHZs4aQRhOgzWML/SY3gn6cIf/TMQLETm0PVu9YNhD4zUSdUM9zoHveCmTWDAeF+w8RTnhDAfYaKgqFwN7yg9pbQzD/11DwNEsdhB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774915; c=relaxed/simple;
	bh=tDCa7ypFvLoWhXF3E8eC2MDG7wG71/R39Yigupo+2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGH0MaAVb+fLDuD0APA6hqiyxvbeRs9U/21jzE3ceQ/SN7y8asXTlYcQe1DO8aquUO70p0RsiMnd8ZmDb0uaskWxejcu5o0bHISd/QDcDIX9qP2VbDZ2ovqV7+rLcfiSQdovlIEnmLjBii+DcpQGweFZ5YFiqp9YSiCh2njwSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPZy4pId; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPZy4pId"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39b52169dacso1053173a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774913; x=1789379713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kTIH4rp729nLZ+mp+FLaZ9eDX+y2kMWtUzXLWEWBJHs=;
        b=JPZy4pIdEyja1/Zz8cD7RSlL9A6TNFwv2gmRwTipVgEN2aZayza5B04LfndeTDlldu
         XnRWw2GjPP/1PrCA66SIekfaRzPzlnBBXLLUkA/Rl9m95oscfuwySc/tcNLz/5UL3ObG
         gmOb70WyJTwx3gQBui1fVFBYiGCtNY7s9g8qwQw5dlqdm09xFbhuy95wE3YWoKDu1zXm
         QXejF3jxhharvDWxA5V/W54BhE5DsBo7Qte0PfXGcpLu6pcWejcdfUqkU8L3Qa6inFDp
         68f75roel78iT49xuOM0HT1xUTWIbrtK/3kpber6bsYwUMu59kHbzfBNKnz4XvxqRAeM
         14WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774913; x=1789379713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kTIH4rp729nLZ+mp+FLaZ9eDX+y2kMWtUzXLWEWBJHs=;
        b=Ytpmbg6m7nANVX2GuRtpY2P/2ZFtnp7xHYQXqPx3Dvsv/EsDDLcjTCznrLQUcaxOOD
         TAHtZGExU529iM42vLvisjPaXIucQihf0PQg1IxJ2WK0hI7nBcoGyqIpMsswcrqx5Tk6
         FCTGFZO06vZRGnz4FuHWA2w0bV0jWBNQo8sKV/tLPltQWBiO76NWLlA7LuUbVD59sJJG
         ItTC3zQnHqFWk9z+q0HW0YBoBUcQluih/8STEvY2D+ncR/DQst3Zx0eR4YuNYW3rWdem
         7guWJsmoy9pCHlYrefLD/byvv9824m+yUg/cwv+BAdYthvk6tefN8XwVe5EmkPYddwmQ
         gjpA==
X-Gm-Message-State: AFuF++mVWcJd1ZOFWjwYSmZoFXYZ6eqI4K2vJkXSUAkoJB9ZlY+r9YgP
	VlKHY8fnU3OAW3/tQ5nTXsRb+J1R1c6iusF7OHj3KZUov23RndJiWF1C
X-Gm-Gg: AYBFou1SEWnOqt8A6GGqnxd0nyLt7TaEb/mBBvR6Cwzxvsj0TLoAtIumuk9bWqIwaup
	x3YtY+xz3KuNld24suOY7wN+6msDLTyD7lnrxNQQ71BHqLAcg6kB7fv+h39LC4Np+ZiKWRYCJzh
	kXa5WmjYJ8EWZOEJ1WN8t4MedN4NTUATFaiUWtXA89WHjid9YcrMCIRRLZk2Sc9ZXeK4bCP3DdG
	xeBKtCnqxde9EQh4aO5TzJERUiZBqb1MO7hHsYKonKeNgDWixRtcvQ72sxHPGQ2zM/jgg5DNdbL
	E45JIZDgFonrNQfAyJ3qGSzgobKMUBng+z+6YISubxY8kMLRJAR3oY3Wsf9V4xiODd61sjjG4sn
	gyjPH5esE543RlRuDoWlSBZmWtYn0w6ip1WTGT28DPyOnlNMaVzNVT6uuXDgjqr2mah8otmKcg0
	ugbYb8CYh5V3L3bHt5rxwlqVQsL5cQXJP+B82YolSNn2AjIu1F8SVBnsXvSvBwbPv62Vzh9zf4t
	U76enCvB554fA==
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr36070397a91.16.1788774913277;
        Mon, 07 Sep 2026 02:55:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:55:12 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 4/4] Documentation/eth/intel: fix repeated words in comments
Date: Mon,  7 Sep 2026 15:24:46 +0530
Message-ID: <20260907095446.27290-5-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop repeated words reported by checkpatch.pl. Only touches
documentation text.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to iwl-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/

 Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 53d9d5829d69..e01f0adda3f6 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -692,7 +692,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
+hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index eb926c3bd4cd..5840569917f5 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
@@ -171,7 +171,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
+hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
