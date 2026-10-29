Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260228;
	b=3ozcLG8id5ijCKRLwxya5hvNPoljd67cMEBa38uxjEwZnm+mM52YuzigvBl517tGDnSL
	 LSNwIhLH77yeAjSuPB5CZJo+xGhcswT+MskykVaQIFlFv81mG7GzwIRqpgoQeDbgz//cS
	 Wv/5dTNX7zsvdwgJGVrsYt0k6tlZY+n8aT9RbOn7PlweRW+g24dUExRRbLNTsOGNHs7p7
	 mUCXl8znsqt4hg2zH290e/A3S6rMipGj7DILnzU9i6Ei62oF5VZH/hIY9CcYv83mqM3Jt
	 Ed5KLRMbIfR/ja2rOiRMlpxqCFyvAU1x2e7oGQpue+nq2kXUs6J7PQPRHjGZileQwFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260228;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	b=bUc0nnziBfjX8xrP9iwn3hO2Do0TWUVb7RgI4YY5nObc2IRRRXthisshXEl5tcAEJ45j
	 EXCFbIulhX9y+OdQ9qBjIg6/H/YZG1zAj+wJePMXIaRAc6nUiSxSXEv3OeuepE17zkeF1
	 m38aMETRwgocQikArHnXKVCZm8lU3vFFvJqKA+SGd1AXR61CyxYvzX+2IM9F8al2Dd96x
	 AYIHY+RSupLSgTAFb77ivbJ8eI8a8iVGnFe+RicHzV5qcN/vwdWkBp/eflix1EMH37X3F
	 7fgdyEhmoKNKtwmNOf/R7FMW7xgU68eUNY1K/l/xh7lb/PIYI4dMz0C79yJ+lR5w6JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQvhmNNG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6818606A31F;
	Thu, 29 Oct 2026 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQvhmNNG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E621F01829;
	Thu, 29 Oct 2026 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793260227;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQvhmNNGK36sulpbupSyeQgY1/i9+fLhfKPjqtpZZHmSjQ6BrwcE1Rp2Q31WIMrdh
	 +tOMZmch+mgXAAcdaT63O8teV+ztS4p1KYAJYGFBC/o4g2DEhXk3OlGKODjrStmicC
	 XOw5tO48cUIZx0ZLluprc/5kYSX5cT/103G4V0aaodLKtR/zNV9KcOcw0RA+OPoYtg
	 6iri4zFlKtKKdZMfv85qI8qlfR+mNaQN5I03QXKsbSyODaaWUA9IpcdsRj0reUT5hX
	 7AYWS02SjiNrytftHzf+psdPT6FdfWic4byezbTyrLtZlxjbkCqkUkYm8pTMZvL7vH
	 wCRnVGvFvWpKg==
From: netdev-bot+sinfo@kernel.org
To: vmukunda <vmukunda@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Naveen Mamindlapalli <naveenm@marvell.com>
Subject: 
 Re: [PATCH] octeontx2-af: fix TX hang after link mode change under traffic
Date: Thu, 29 Oct 2026 07:50:26 +0000
Message-ID: <179326022661.3327.15804422690861412603@kernel.org>
In-Reply-To: <20261029074635.4139111-1-vmukunda@marvell.com>
References: <20261029074635.4139111-1-vmukunda@marvell.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
