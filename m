Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624043;
	b=BHGa8XeEU8nxlv4Dtoq9Ac7m0GPWJVV69Gtwww3o7m6NqIil4urq5/5Xa+n4eE3GT1ee
	 X6mX0cPBkzB81ig226ymuwbUuuglNfzUHitGEtI+0xcsZVylAZnILNw7nx6B53P1se7zR
	 8VvTemY3EnmtCWrwLU593N838S/L+pewCOBglf2iUIghplZQDO0uIkHm/cndqe1YYrcHH
	 ZE8oBsElVJGxLYdRB/80pHDDR51jIHq2lYCVRlFjZaKWeV/rzc3mS+t1gvXYqE/oiqE8L
	 iQ4oNN+3lGi+Edb3aRL3p7pL1aBF6LI/ZVBLAISDP1bOADIdizHutKWOBlMThw0KtxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=JnL6ZQkIF07BoBG1+BhNSOF5Oe5g2Wx8HEpMeNtsA/sGF1r+yBaYwzCrj9nhQyqANtX/
	 6mpogXxg21Lt4dd6C7/TKNxHVPI9AkNXO5S9EqYRwhmIJ2+A2TCXQMkhAc+zhVNcFj7j4
	 S51ajoieL+XAZyjhR/KjA8EVUo0hfVWUjeRFE0jHtHBjEWUlHzVaIUvK8hY6w1Lxzs0Gx
	 9xVsyAopXG3K/0R++QcBMBSb5s+zzXGTTqmWVoU1/94CbDUO51KwJeqb2cu1i62+bhZgw
	 Z7zvXLIHe/G+5x/GHnT3LfpqVVjO+i+YFkmLmHBnFRM7ZQ4J5XGk7bAU+qefE88je2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEZwPl4T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D7606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEZwPl4T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA6B1F00A16;
	Mon,  2 Nov 2026 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624043;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEZwPl4TVbKc5q4FYCAyZeuoqTY6Y24tf1qO8JAWaOIYy958WHuimh9510qLBX60y
	 XajmSQb8IeNVWbmz71zxnjhRi1K5L/SXhpfWj8Ch+6Y+eQaJ6YkgZMX9RsMWxMfQLi
	 u8YzG1gkKeItYtheviifTPtemOE0MfOk37GZ6omte7Hj+/Ax67+tZGzkWdUFPNQEpd
	 +e1Xe9w1pJaH948d93qOBN4gMBw3ulavBI/xFSKVoxL6l0mhaJIY7s2j6/zU3fMNB+
	 XZQ72TQF3lnqaZW6rWK73+iPBrUoK45IPYMJveW+L87/vXqFCYmBlixqXCvRnZVw3a
	 wXhD/7r9aHQXg==
From: netdev-bot+sinfo@kernel.org
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com
Subject: Re: [PATCH net 0/9] xsk: ZC mbuf fixes
Date: Mon, 02 Nov 2026 12:54:02 +0000
Message-ID: <179362404207.3286.3886474571191338888@kernel.org>
In-Reply-To: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
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
