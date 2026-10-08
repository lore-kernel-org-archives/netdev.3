Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D713B637E;
	Thu,  8 Oct 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447593; cv=none; b=ARMQG84AiOg6ujdZ1E4Th5UdkI7hS7IRfqZu6Ky/cIiMtqKTEdJQt9yAqwpelcNSZMAU0A9qHHHAm1pFXYpxZUbWStZ+ZCsLw3+C6f4qaswJ72/pFMhZ7ZPn4QgmqlJ/BJQbJIgKCMwSdHEMjNH+tO42qNsb7TT8cttnsAy5/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447593; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPykw4MdyO60A6LcAA7s/jMuwsQXcdIZg1t6oeLkfzmmNSs9HKmkCV7rE0wuDN00apuQob9PId7tocnLcvV0tF2CGEXMvjtrefV3P2UVln2Sv3bRCRG4uPzTbFjsXYBdabwNgImtGNvoL/f2+asPaLnLN3Q2xYz2TeA+/UG9G48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i99qalnN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i99qalnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6FB1F000FF;
	Thu,  8 Oct 2026 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447592;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i99qalnNu1vDUlYenDAfjMkyj6hUz7KwTSNeII8EXcOPSkAsbHI1uvzI+xRjocABN
	 LQWzAMa/PqeWWpDLM5gRsIOQhiNEusmtnbBQYL9mzvU4LQkFGvNMOZ1x9UemzNn1gT
	 1RHimFcDTqdAYx6oH3DcFi8dJaC1uKH7WpYFDGWubH/MkIpuoqcQ+9yLO8ZiPc0/za
	 G2h7fpffdRGUUBJQEU7mLT58EOWM9kWInZD1u95gEi5V5O+OrEasi4f5luHtY4SfQT
	 11qSTy/5Iuhr9Xh0h5hoiSKUwQo6Q1tgheAy8Nq9q7heD+DW/VuoP4knspt2GgK3bB
	 pE7S9w/XUqI8g==
From: netdev-bot+sinfo@kernel.org
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Subject: 
 Re: [PATCH net-next v6 0/10] r8152: refactor and extend RTL8157/8159 support
Date: Thu, 08 Oct 2026 08:19:51 +0000
Message-ID: <179144759170.2527009.1294478643756602720@kernel.org>
In-Reply-To: <20261008081556.47901-1-nic_swsd@realtek.com>
References: <20261008081556.47901-1-nic_swsd@realtek.com>
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
