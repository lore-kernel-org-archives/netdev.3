Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793921876;
	b=4YcCeH/qA3t4Lzn9y5yL2bWQw7+DNvnP3qw2+CKB6kBnSN+bVGblFZwb1wBS/HhmVAYQ
	 afw8wwRGBVCxWkzLcprbXnNYlUM7kDq5y2fc0yy98hKwV0GWiITCS1qAGZRkjnRz3nIvY
	 SPJ/UOkM8DPN2Co11SlNQRmfgXEcMis1WK0A287Tr0PD3e5bJDkZ1J3yCkKHdDNvMUZhg
	 k0CY8EH78pZJADFTr9hVrcxXrOpzU/MIlKjH9d4rElS+8lxLqD4lEPbzqkJCnDDn3ZKwR
	 kNReNlzZQu0kc507NE9jfdz5B4l/oJOAtSjuLw4/W4A2rq3iyMKjYY8Rjt2twR4JPBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921876;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9xgiva0IAXQ/QeOCsMn1WlsEabODYcqZt9W6pqi5K9c=;
	b=JyPqM3oxlHShb37jbbTNON5E64XNrnNjYV4LfuhTMu9FL4QsRhcaafXag8M/+XSQohQM
	 XWF6Cnzh61pFnCJayAsCD17bR10vnIRb83WZZulos954U5U3YN6OYSY6fKNu3g2aEH33u
	 ZflrW6kn6eq+nSyR5aVOA8GlLSsfFl2/tMaFwNXQR7dqQHfyjRrLc+74fLL9rkGDpruFr
	 Xhj4uXJk3zQTDaLqggjCn53NlEnGst1NeI7NkRZ20rAqhaVaAtaKbGRPfe6iwP7EKnNVy
	 R+bYOF9DP8J/Vasg8DTNxQvRFMSqhTQQVoqkMNc5jLH7/8MTDAjeyfR7NOzH8nMf31A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOMUdHIg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027A606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOMUdHIg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18831F0089F;
	Thu,  5 Nov 2026 23:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793921875;
	bh=9xgiva0IAXQ/QeOCsMn1WlsEabODYcqZt9W6pqi5K9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JOMUdHIgD2tnHlJbXda7ZVYJ4CPiXJeAkc6m2KFzAzNi6sEWEBdNrK74BIdWbBiBU
	 MOWhxsYResbNmtjVrmrFtMyT+LQZnb1QF0tPD0wSqQ4J//KkVwE6G32dvqUW+OjsPK
	 7mt921Lew1GKWikP+SgUHqPrrMAbY643mqTuLl97hLzeLVXTaJWHZ4B+oqtUXhwhOa
	 7GaoRNQ4z2rJyQUA493uqV6+jk17JKSBHcN7bc+ofzY7V2akWdUUKYHviluDYKCoul
	 QlMeEaZ4dN/uRuLpSGoZYG3CpcEwy4FYPVUkiKPScTSvc+k5WHF389bfo/2MGih1mV
	 cXcmTP7S4N+Bw==
Date: Thu, 5 Nov 2026 15:37:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v11 net-next 0/3] Implement PTP support in netdevsim
Message-ID: <20261105153755.78009e5e@kernel.org>
In-Reply-To: <20261031162804.1893-1-maciek@machnikowski.net>
References: <20261031162804.1893-1-maciek@machnikowski.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Oct 2026 17:28:01 +0100 Maciek Machnikowski wrote:
> This patchset adds support to the PTP HW timestamping emulation in the
> netdevsim. It uses existing binding between netdevsim and ptp_mock
> driver to generate transmit and receive timestamps.

The bot will not auto-respond, please make sure to check before you
repost:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031162804.1893-1-maciek%40machnikowski.net
