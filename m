Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477C371899
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534255; cv=none; b=CWzaxvaXiYV1Qd/4CBspxi5ggQBgGMRkzGMMosJmDKQQ54HywNyqnrfEXAq+TQTYYKORNbU9pKUCxo3vEMB5Pzr+V5xTgmdqNbAMZESlOllpVn/wBumGVnsrHzeHsnXrIlFPpdigAm7KYoyHYowaxnENknIf+V58mkmiIjKW7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534255; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a22gXqQFsLkBU461HeiQnZfAGe6S5enXanmlTP6O7XUWaY5VbwXU/NhxbZTWab/npuzele/fAqFdND1NUGr6Gd/QHAucO1Ld19ZJoDahAyjQQ8Hp84PkvkCsm26QdQORaKHXvMDYoIkEDFwOVL92eJXuqUJ7jUqZRgQz7SHlg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeUY6XZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeUY6XZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ACA1F000FF;
	Fri,  9 Oct 2026 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791534254;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeUY6XZmiUdjmjUkG26QJHBO6W6LxHaql9BnKZ7sy8CuHHbvbxkpQMil2TChTUi1g
	 mtz+6FB2IcNXhPFiwjTFfTTWRwHOSj9OP2qeURyoqo2iyB8YXNktdooHtVZKktb334
	 fd4oVGvsyAma8BQ0vhNnHMI4RPJq7XVLB5LG5RSLNW24znxcBOIus4T38ID1Fo78oU
	 5KX6SRe22lfu5f66u/M5z92GZOWheL+sWUZFQg7F6Gknp+cNwE1pXzqZ3rK9XmMaOd
	 mkA3P5qaXf1jOjRJ2lN/LZhzyGXgEp2pTMjDvvjujaw0pbNGkHnxGfGqTtTOJLn6e+
	 gJ4oN4odw601Q==
From: netdev-bot+sinfo@kernel.org
To: Wong Boon Jhee <wongboonjhee52@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH v9] net/ncsi: Fix use-after-free in NCSI teardown
Date: Fri, 09 Oct 2026 08:24:14 +0000
Message-ID: <179153425417.2527009.2396425822605131599@kernel.org>
In-Reply-To: <20261009082201.1424955-1-wongboonjhee52@gmail.com>
References: <20261009082201.1424955-1-wongboonjhee52@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
