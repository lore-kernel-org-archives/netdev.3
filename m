Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194476;
	b=XC6FwQVt3TKTX4wbDrcw3DuwWKlvx3Br85L8GSUIKYPVRofY3hoIDYU/S7iCa8P08Y99
	 prLel4zxc8t7ny65e3zdpZlX/Ji31Jl/8UPijICKAsrhp5IbThfGjUn0p88di/CtA6/uW
	 mE55XP6ymaqrgshi6HNGKXQ3UKO4Pg4uhQjNZbt+bV4NePTyLRjVMw5b97RkuB01CeQow
	 pJ4YrI/gTzMHw8amf5AqdlBoyBurupDAU9Y9FsqwU6YDh0JrO+H6Ni1Hl5IVUMrjWABRB
	 K06fRZjDTo0Zi+rEVdEV4jDhXiWUJFihvnyQHtJ7uuiSxzXmVG/NunwpJhTxX4Tussw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=acWunQSIzzVlGDIcltnxwoqU53HIn/lrZc0Hy8R/cxB0UpyziHH4SllLkdBmt0ptAvnH
	 QacAbod9HQmOE6DMBCsLMog2zFw200lUCC3n75jG7WiOHl/M9T5HgWzYxKlawFXaIXeU0
	 sDedfIShVEyWiLS29SwS4vVSy7U5HSXZqB7A44YCSg+AqqAr0YDZTV2TTBfIqzUtZ9/0o
	 NE9RuI1wW3K7+IbWyCqS3x/wi2VcMtQYrDzVTi+I6Gn4lu8MeL+BAG/UVG8vzCToh6+Jk
	 wgtrKjdxG7h+aInm+qkmp9YoEXWR4hdUQE+dZu1kUdOb+DJPkmwuUXNukHVJ/+/Ffnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfvgpl1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06594606A31C;
	Mon,  9 Nov 2026 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfvgpl1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C751F0089F;
	Mon,  9 Nov 2026 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794194475;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nfvgpl1OBKyZRM+kcsOhd8S7TqREVkdsk+zLhXRVwuZcx9hN3C3h5FpvwscGvXEFA
	 PCiHXo0fYlGPGZ35H5uD7W6J0ccMSbw0VpnEuC8seOCoDCkNDdnCTNbtRO/9jiIam9
	 ODbGDJJUph+CcuTajicXo74kgdwzby8VzwubgnSrlLg7DfqFMycywOi/zGHV2Iq1s8
	 2uu2HJzGSGFkRH7xttF8p+Rxzh7IdDL5HOIccA8ccJegVUJUkOk3PI4QREpWEKBLOV
	 VkHxAfo8PzJLDua0Titu8bSh2K6sGEItsnbAPmhiI9DrSwk3MEvJHYsNWKtqna1vCX
	 m56UmdOFrVQxw==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
 David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Thierry Escande <thierry.escande@linux.intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 linux-kernel@vger.kernel.org, yana06070@163.com
Subject: 
 Re: [PATCH net-next] NFC: digital: fix target leak after Type 1 Tag discovery
Date: Mon, 09 Nov 2026 03:21:14 +0000
Message-ID: <179419447430.488859.5809759694387881043@kernel.org>
In-Reply-To: <20261109031832.37642-1-yanxia@cmss.chinamobile.com>
References: <20261109031832.37642-1-yanxia@cmss.chinamobile.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
