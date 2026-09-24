Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA541DEC9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291558; cv=none; b=WSB5T1eG8Nk6Ite2W7rmE5fThGM5wjefv7VIVd+wMZ5DQMU+x2YBN9827Cwu6OrsT58G2vH+AKXD50FxDmPgF3yXak+sxk7WsE9A66mW6Uo5+JOOXmnJg+FSbnS/E56TsR7D7ev7hVUWSMd6f57Zu5J3LZBLDJdn+9PBGCLicak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291558; c=relaxed/simple;
	bh=Ds64uV/cQ0EoebG/EjBGw83PLBAsVUBGr3yVLK4dQEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psbXzZaJBi03ZafJnQRD296v0BTlpd98Dr/Go588zdD7lnQPOakjjZIKUjxdnNTuQGCTMF77mFZJ50RE4MRqsNK+h9wux77h0oTDpPipZR5tUTYAsxzuiAqzkEnZt+A+qquYvxuTV0J/pz/ScCKnOj+IZIRxU6QdWwxybplGhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+kYdtSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+kYdtSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2941F000FF;
	Thu, 24 Sep 2026 23:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790291557;
	bh=QenMF9dxZZ6Kl44EwmPVBp/k13hs2BZg4shzi3Rj2HI=;
	h=From:To:Cc:Subject:Date;
	b=A+kYdtSu1dH6eLaVap6urWlYq9iu/sLgMqYgoFwlTfBprCHr8Zw9wa3L0DYS9YIu4
	 5RWC1HFgY5vNw/efPX2almkSNjUPaht09W4F8vRdPDRjI8IgEaROuf3TniJ9UVmKHO
	 gk3ljL0f05M7u9BBfkP/snn+3BswrMBnKcyj75U5xKIkrPTN6pSZ+pjWm3/DaGoLxz
	 hXg8M4epLe6SNcFbuuRIeychUkKCXcRtNUeE+WRneAtTYN5CA1YsNl6y3SktAFmm15
	 uxo2//FqkHTFZz9qF7nvdXZTerC+Zjz5Od1uTzM5AT7YgAbwHQTao+rbwTxZ96OBPF
	 F2M/fjc4TKfbA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] dpll: fix LLM nit picks from the spec scan
Date: Thu, 24 Sep 2026 16:12:08 -0700
Message-ID: <20260924231211.568213-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues found by an LLM scan of the Netlink spec for DPLL.

Jakub Kicinski (3):
  dpll: do not truncate the requested pin frequency before checking it
  netlink: specs: dpll: declare pad in the nests which carry 64-bit
    values
  netlink: specs: dpll: drop the reference to DPLL_MODE_DETACHED

 Documentation/netlink/specs/dpll.yaml | 7 +++++--
 include/uapi/linux/dpll.h             | 3 +--
 drivers/dpll/dpll_netlink.c           | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.55.0

