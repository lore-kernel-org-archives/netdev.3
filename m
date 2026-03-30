Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0C3BD63D;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867036; cv=none; b=QnccX7QL/Brr0yh23xLlZyCNBjKfxQ3PM09XYpk5xrrz2LLzlZyOJtZoluQGXDhUFcTuyBqTlgxhs8SmmWDnFZNAu80f+nVR256dkEB7cgEulFbVSyfLPU6TWXUZkebPy9lj6UjFy6qrF/f+ioDGMUb6X3goIidOKSkvJzhIlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867036; c=relaxed/simple;
	bh=Wuj9wzQSeaoI1UP2Rxw8a3jZFk0scJPGzVBIPzjE0QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJuO2qKrkpqwEr38FU08wQ613Q/+kF1cQtzL1VNNvMumrxDpXXFxEAVHW6TxNwymdghsGrNsQC5pJRgxK+tTCMb9KGlHENWCA5On5z5p3PBvNg+tFVdCDjL30TjFS3NvcPil9Oli/gTuynkagMP+/A0TLG1mLsSTTXK2YFGdT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om1yCdWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om1yCdWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F97CC2BCB1;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774867036;
	bh=Wuj9wzQSeaoI1UP2Rxw8a3jZFk0scJPGzVBIPzjE0QU=;
	h=From:To:Cc:Subject:Date:From;
	b=Om1yCdWumupyfTwxfn5X4O4pb5fvrpiG1KZ888DXxkLgqhqHq7wgJwrOp9ZQLmlHR
	 Opt/wW1bRxnMvFElfkLhKXqS8cPQ95+qjQHz+//+gDG+UJzlkvDpIyW70hBrpQvS5w
	 l6B6V88VBofN5dKEnePbZC9vtQ3slRk/72rHQJbJfYL9VeArIHJ+aesybdzeROtpw4
	 0brdFhaRlXHUVjU99Jqt1h3082Jsg3MsJ6d00kpUv3Tjfg3B7S6CvIwCOnaZyMjhOp
	 V73t0MgY0J1EFRDuOOtgCV8RGzuI6/gng/JRvgx+VmM+i3Cz0nw5QgN00is0Zl740y
	 ApFWEKrUL0nHw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79zd-0000000713S-48Lw;
	Mon, 30 Mar 2026 12:37:14 +0200
From: Johan Hovold <johan@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] nfc: refactor USB endpoint lookups
Date: Mon, 30 Mar 2026 12:36:52 +0200
Message-ID: <20260330103655.1672331-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Johan


Johan Hovold (3):
  nfc: nfcmrvl: refactor endpoint lookup
  nfc: pn533: refactor endpoint lookup
  nfc: port100: refactor endpoint lookup

 drivers/nfc/nfcmrvl/usb.c | 20 ++++----------------
 drivers/nfc/pn533/usb.c   | 34 +++++++++++-----------------------
 drivers/nfc/port100.c     | 27 ++++++---------------------
 3 files changed, 21 insertions(+), 60 deletions(-)

-- 
2.52.0

