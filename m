Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC61624D5;
	Fri,  2 Oct 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924373; cv=none; b=YoSMK+DKg7yLJlOLFnrCjcjJU6K6Dym8hLp2udPmoqwzc6Tty+DCpAZNUlT2EK3SeNBEfxReGKVIDmFSTWVwfFXNfeUcj2o7qrtqV/SSuvEkWM44NYrvqvlxPdBLsyzQ7P5ktt1Az6n4z6MF7ID13DMqpaSWmi0b2+64RjNXO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924373; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/OWe5v0IMvzEi4nhTSh464hBo2T00v8mKkhG2Ic0Mc3DF/tT7xaxHMZVbnSfQKnvYZvknIyTNTsmJtyBHBMtcYiu7WHOtgyNuYdmQjM5qeu3tg/LZGwljjDC4rSFa7vliEftKrfPsy4y8KWz/HS3WW8NzBMenUP7grgg3MQeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzVSydex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzVSydex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE3D1F000FF;
	Fri,  2 Oct 2026 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790924372;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jzVSydexYw512Ot8QZYmZKAqI+l40yeJlmwSGSSnP/qMrLa7AwwVLql9bNmFpZn3o
	 2eg2qGb0Tq8wbKnqLfzPy/nocmutm5GcEwKiqAJkxpCbBXyy3XrsIMrBD0X+lacIvm
	 DWOL4bi5ppA0qfeJOeohO603cMAZNhEvnlQXuFI1nXyP20jbeKG/h8PiTB/44Hffl0
	 +bzzX3DilEmuZ/AVHPMHX2cdt+1PQpbhhT/UYl3l3JTBsdX0MXkHoKYQK7+B0v+4eS
	 vAd7pvUQKD+EhN0Dj9dOSoGk0cO47hJzpIfxUCDosgXaa/1gKIZmv0FpUumibI0VF5
	 K0VLO8IfFvJ5Q==
From: netdev-bot+sinfo@kernel.org
To: Zhengchuan Liang <zcliangcn@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/1] net: netdev name hash leaks kernel text base
Date: Fri, 02 Oct 2026 06:59:31 +0000
Message-ID: <179092437135.1402591.17012333474783660749@kernel.org>
In-Reply-To: <cover.1790917676.git.zcliangcn@gmail.com>
References: <cover.1790917676.git.zcliangcn@gmail.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
