Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B38388E5B;
	Tue,  6 Oct 2026 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313614; cv=none; b=t1wNenzHHjf9wv/RjYV7qnqHusrRTc5PCO7qaX4FsW9jZ0HrPfRASuxXwl3zQvX2iOQrhWAytA+qBygIB8S6aLqws3S3UAcUCnTU890xFW7kXaQxqPukB2UMSXSt8/6yfzbmEAfsPxyGlzRVsvVpLLox0MIkjAjWxruZAHtvayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313614; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JmAIl4vy0qRoBa/2ZkVrKBm6IkHxjCdxK9rHQKCn2S5spJJyECArL12/S5hLvF6/4E7m7ubLCo54Q657zDirK8K6IL9qex57v3vcvHEkNiEb4cgDFAw6b6dpsf6+Txah2GD/R6g4LS5wnFy1cOTdIpRWmYZ691Y+b9kk4tYZb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aocjp3zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aocjp3zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA1C1F0089B;
	Tue,  6 Oct 2026 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791313612;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aocjp3zQSwrjm/UPfB0rCYjwzWKhaVmDkiO7ponHzDbw0kDubOO96HBwbzbh8LP+D
	 ZnkR2Ytx5MrvOQTDcK93fR0b/wJ4bGGiA9JRjCaAcG+gyjnOIXqSuJ0vgAHdseNYmX
	 qNuJfE0CKZzd8qRssHrQksrVDC+Er8gRhar/Zq3WkFJM+qjRsjW80V2OwYd6W7Ce+J
	 CuEVAOP/FFNffEcuWuhk6a+rVlTICpkVoUo8XvTJUTNbKuuTOj8EBbsIVWvWdfyO2Z
	 jfVbSRoTYhVUOcaFVebIhBz63MZ/hrMyJX0f0Q1gaY0H4KiIwFbjdIvukrw+KrcjmO
	 FE8FX3M9VNH5g==
From: netdev-bot+sinfo@kernel.org
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <netdev-bot+sashiko@kernel.org>
Subject: 
 Re: [PATCH net-next 0/2] netconsole: add locking to configfs _show callbacks
Date: Tue, 06 Oct 2026 19:06:51 +0000
Message-ID: <179131361154.2231598.14566861570610111064@kernel.org>
In-Reply-To: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
References: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
