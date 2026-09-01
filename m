Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D047A88C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254504; cv=none; b=BgObUJB/LKC/mfgUAFXvad5xZDCgzlyThr+q/tfcdFYdRaNj38+L6Z/lce9nmz+pg64mTZq7bdQUJkE5mZLUj82WcuBDTkkf9DEze9NVBvBHnkXdbYz045WUVMKw9otTw48PqfzOXgoKyO247uMw4cIKnSOSa0HBH0ERCHOXp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254504; c=relaxed/simple;
	bh=LPktyBbqtUdmyobyyl32Ps4czEQKx4pybU12/Vq8Pmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lx9cabqJuOflmEFfSjw4pigIhjLU3etlZMTEzE1HwBxkJm0gA2fmN+BKmsJgzwU1fFPALFrKx9U1bqrPyDIEmUdHkue4HmiibqMa5hQiSNjW0Hw3AFzQNQzmIIWSoF5ulUZLF/H8IivA6a4vm32E7N1RF3PeR54UC+tkDrnNRlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIVUWaRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIVUWaRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC691F000E9;
	Tue,  1 Sep 2026 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788254503;
	bh=S9TvS7BP83emY8LHFuX7qgV/KOvXunyEorU5ViY02Ds=;
	h=From:Date:Subject:To:Cc;
	b=IIVUWaRbpo31PuQFZJGRMVpikR5YqFiQu1NkGGN1NAf8f8sljMGSkfRni7T2LR4Xa
	 WeLX8HO8py1lSuJl6SEZ5T/dlBaToPu6cGefLD+rFstGZQyb0RoZ8sr1RZ9bZbpgAa
	 olwwPMGlO6oVFjKu0cAedX5h4/Scd4CGEjwM9AKqgMQYhRlS5sUl5GYHgzU43J6vbp
	 iUTI++fJsshxwuRaRKN8a9zcziWQdEAYdRmTFjb+SGxPAeBQqbI8ZKrl3ZyZ4XFvMn
	 K6qnCglYP/x5zxUztsd4F82A61CiAZGUvGWCymhY3jaq3uCGknXIdZz7km5fVDX/4/
	 +bchYVPmCV+ZA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 01 Sep 2026 11:21:24 +0200
Subject: [PATCH net-next v2] mailmap: add entries for Lorenzo Bianconi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-lorenzo-mailmap-v2-1-0ee832de0caf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBREr0L+2m9omxR15T0MC8Qp/AgtaQlBC
 Xe3Ye/y5WXebJQQBYluxUYRiyQJPoM+FdT2je/A8spMutS2vBjFQ4jw38BjI8PYTIxKVXClcfr
 qKK+mCCfrUXyQx8we60x1Nr2kOcTPcbWow/+tLooVt9ZYBaeAp7m/ET2Gc4gd1fu+/wBzo/N6u
 QAAAA==
X-Change-ID: 20260831-lorenzo-mailmap-e717ef03f29f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: akpm@linux-foundation.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

Add the active email address for Lorenzo Bianconi and map the old,
no-longer-used addresses to it, so that git can attribute his
contributions to a single identity.
This is done to avoid bouncing emails sent to email addresses that are
no longer active.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Added missing SoB
- Link to v1: https://lore.kernel.org/r/20260831-lorenzo-mailmap-v1-1-c6361ef1eeb3@kernel.org
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8fb9f3898d7a..39b77eb2db87 100644
--- a/.mailmap
+++ b/.mailmap
@@ -546,6 +546,9 @@ Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
 Lior David <quic_liord@quicinc.com> <liord@codeaurora.org>
 Loic Poulain <loic.poulain@oss.qualcomm.com> <loic.poulain@linaro.org>
 Loic Poulain <loic.poulain@oss.qualcomm.com> <loic.poulain@intel.com>
+Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi@redhat.com>
+Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi@st.com>
+Lorenzo Bianconi <lorenzo@kernel.org> <lorenzo.bianconi83@gmail.com>
 Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
 Lorenzo Stoakes <ljs@kernel.org> <lstoakes@gmail.com>
 Lorenzo Stoakes <ljs@kernel.org> <lorenzo.stoakes@oracle.com>

---
base-commit: 25c1f6111034aef7fc06cfbdcf1e4f0d6e5ee74b
change-id: 20260831-lorenzo-mailmap-e717ef03f29f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

