Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5643FD06;
	Mon, 28 Sep 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593178; cv=none; b=aBbjxrESiO9K32P753PxG3f2+u+5G1d0iI6UvVSOovc/7SN3r10vU/AGTiWuStBbmbHsQ5QZp1vDEpAzkpAJMQxC0ovTOPGnO4lupz/HO0vae+ZGGfs09ZkfJSWWOjfJy3+dvCVFAJhGR2MeOVH499QcrTHX19RBuJHnhY92HUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593178; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oi6J0GpkQLUHY9USoclY7+9Bk72ZE2D+7eiSdpzVda7CVxXavANo1/+ixU8XXumP5klLOCIHQr6bjclB0SrK77DqrePjP+stDbKviSU1tpGRku/5klIm9vnKp69V8/q8eqLsb+5NaSbYdHGUQ/s5UUnrfx4pbM8v1mNWZXNtYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4Gaw+R3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4Gaw+R3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6E51F000FF;
	Mon, 28 Sep 2026 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790593176;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4Gaw+R3A1cyZEj+ij74KCj3J8wHQ11HbT+/c5bWxT2WWW+koE4SBJyblrf/8z2Wl
	 niLObN1adIW6tLv1cMbHxV1tAb4QuMIPpj9TyGgyJn7zqdXYrAihGtRVvSBk8v9Vx6
	 zsCyXq99LgCuIpM0FL03jKaiZPWYKjFwNSAjSZkUhbGD7w8jJMSSyWf8ONVRwRFOnR
	 BNWhYu3Yvk2h/XntRzQAPM0ZikSAjirjwPtZwPNcuTQkF+L0jhqDx06Qg++A4yhF7T
	 m9vILSOBO9WZuXSAINxkn/vlgyl94Tb/xM+Hk9qKN/CmLwP5MxW5W7xX/kT1qQ6az2
	 x3x4OK9Sw22yA==
From: netdev-bot+sinfo@kernel.org
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Justin Chen <justin.chen@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: fix NULL dereference in set_coalesce
 before first open
Date: Mon, 28 Sep 2026 10:59:35 +0000
Message-ID: <179059317562.31693.7518349114735075126@kernel.org>
In-Reply-To: <20260928105642.856210-1-nb@tipi-net.de>
References: <20260928105642.856210-1-nb@tipi-net.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

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
