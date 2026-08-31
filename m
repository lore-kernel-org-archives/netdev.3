Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B26223DE5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 00:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135748; cv=none; b=Kl/S+WV5SLSn/7l3HwO+TUqgqeIyOBa/NEDtRvlHlYPJy0aZUSVm9eEz3FYBwLKtcHOesLMYLkoZ3c4IXY6APtRBI8On/hQeVqSI+o7OHs6NriNwtdRIEQAqoZ+gtle9XZa9PvSiZ3zyPEW13GEHdE1Rocmsp1uN/VeMYOHjgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135748; c=relaxed/simple;
	bh=HK5PYN1O7Z6ScW+6fCY9nJvqN3ZMWsfvu8sCirWXC8w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=go2/W3o7UPa0utY4/Em6IhX3tSrBfjj/hXOxgZcZpUa2KosykW4oK2/6LcjdNrO6bB4XCzLH2uQn+Dt57lzRLfST5kWXOdDxQdLs6ZwFBft4TjLUUqQ39VS5qRwR8qVCRkB6oI2A7ZfmQ9tcNDFfbhk5YISuGk2lLb2juHA2SVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaAjk1iQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaAjk1iQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C871F000E9
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 00:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788135747;
	bh=HK5PYN1O7Z6ScW+6fCY9nJvqN3ZMWsfvu8sCirWXC8w=;
	h=Date:From:To:Subject;
	b=VaAjk1iQ2zsK2eiEhd8CEYKxlmzQbnwQem8zn2pakSMsDhfk5K7zYF4xcIVr1D9i4
	 qOgMPoWHJ8qE3c7o4sJDYvlehpCj9CvUPBx+RUovdFWBkqF5/0M3q/Q+gsMqN4Hkz9
	 29/SNmZi7HNQhylayn/hU8U4OKuPCYQcU1msVPNFF1pJyUXnKPbcK6PWTSQ63iLoEb
	 cJ0w/B2rnTiRJUuSgIx+PI+5OskeUVjPMODk8xunYUF7rFO5gSQHn0mqv8oBwI5qBk
	 KdoBCm36uEIVYzY/vZXQgTFJahbyeHAC7YkoYLwmhJwj9f8ShqEcJlPn0zeED9KQAl
	 fHV/hKrZ527eQ==
Date: Sun, 30 Aug 2026 17:22:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20260830172226.0b7e7fa9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open, and accepting v7.4 patches.
