Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4545DF49;
	Wed, 14 Oct 2026 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960338; cv=none; b=heJsXu73OxFfpN/Y1erBUMYcEBKDR4pHtEvJdo8gfn4LM9OR2Q3vqwIalJezIQKJWN9JOIQA2UkfbidyD3xRXhSvtFsG8UFK3MANuTCVi6CpaupIwiHMSg80N2ujEzf/AWfgvBC44HN2pM1u2Swz9guJlrzKlYYcFjsFFOBzOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960338; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvkwVD//opLQ9HIj1Bk7fm8cMuTkwW4OEL2HhlgnJWkSRspsEm8W8bifWUW4THkyfxLi1xYa4nvQWxsDIpB3XhzlfZ7vn03aLoggqFhGJP83njKHQM5q76NLb3ih1YaMqcoqUohMaRADCJhA65Uuiug8Ql66VEuOMC9VDgOmH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkCekKF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkCekKF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEAE1F000FF;
	Wed, 14 Oct 2026 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791960334;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KkCekKF+hO/J6UmzMwcnrC3bGZnzoFnXdHnt8zOy3B82Mci2kLW9vqhsMQMmKUz6g
	 5WlfqrXrpn00ipVU8dD0JqaOJbcO90JiBjiNl3DPPpCWY7JA8yunb14lpYu9IaYvgL
	 VJJeBhP99w01h/Adug4KpyAx0uLF9B3pHM+20lHgM0qxWuoKGAj6m+1S+CwgAYWl5u
	 dBwZE7E7u1mruV6ECf4ubqslAfcT02e8tGs37ba4OX7DxNzQ1UubcCR9CnhSel/1h9
	 OzfR/NmBciGEojS40lQbLHTCzTj7tV/a87KwpEiCZoGPy0cqL77b6Qo3WX2yglyff/
	 MVRQLkZGdcNWA==
From: netdev-bot+sinfo@kernel.org
To: Binbin Deng <18983559317@163.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH v1] octeontx2: Fix use-after-free of qos node in delete path
Date: Wed, 14 Oct 2026 06:45:33 +0000
Message-ID: <179196033366.285325.10737861438011888897@kernel.org>
In-Reply-To: <20261014064204.291688-1-18983559317@163.com>
References: <20261014064204.291688-1-18983559317@163.com>
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
