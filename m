Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04306364949;
	Fri,  9 Oct 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554087; cv=none; b=N1xT9bdROrCd7j6qzc6Y+bgvVPvsneyk8wubU1ZJqhkXCGl1aSrYvjw1u4UkpCZhhLF1onetUr45gFQ/uNINSt8H+OkDjL7sDkvvkd9Ra7kFv98eMjic8ZukBGxN9o4bsATpR+Baeza2xgFnwKLE1/tLT12wgZyBsQXZytT3lMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554087; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DKlD+HYv8CJStB3qs/b8dwBLBetM0hd/Ph7VI/mRYPQvSSp7uyz91mJj5EI2xK92sAmuLn/iKTtVUe8l7RBUTei0U18NoUmD34qWnJb3bXbD6HCoGVHG/JV8oYiY9Z7E3mTZU/qKVApp/tivB+KzfLnPzs6N9VFE7sMBvRXjwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMI8FKRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMI8FKRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C871F00893;
	Fri,  9 Oct 2026 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554086;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMI8FKRvWbOl8oaGU9M/aybdX9W/4i3A/E5ok1YDV37ftsgXBsFYoD0u+IDhP73eO
	 oHpGq5TiL/iJIwj7whuio4jltptPg9/VkTwzZbc1tHDoQC1yfubYSalK4CGEeB9P9E
	 VSxO6bhb2jrx1m93KkMnSt0kf4i47SUVmrnvENkBsLXCmKIsXuYymPLPljKvS7LDlg
	 6kPRuq92bZOoAeVzkB1Qb6ZtFnAKR92KRqZIQmajkC54Jil+k8cDZSKzkAIAaB2dXk
	 wC1Q4i6Ot2PhbAg2db6FjiWj0nPid89wksIFjJTN+EwvYm0ZvTr9eEjGV+hwIs3Tgz
	 FO9b2O/OBzB6A==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] esp: fix out-of-bounds transport-header read after
 exthdr walk
Date: Fri, 09 Oct 2026 13:54:45 +0000
Message-ID: <179155408574.2527009.17555985982930326812@kernel.org>
In-Reply-To: <20261009135233.4084239-1-bsdhenrymartin@gmail.com>
References: <20261009135233.4084239-1-bsdhenrymartin@gmail.com>
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
