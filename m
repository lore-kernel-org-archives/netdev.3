Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165651;
	b=F9dyL3ga9ZNmjPrvRA/aAV0e00hMqI7alB9RvNVEQU1VwHp9lBRPAggrQLeZFMKJ7s9O
	 9DiICtRREyPxCWfvVzDqwtvEtO402DmgxTqclnYAPu4zgnpBbCBPKpvygQFX7xtbTW8UY
	 VwO6QMFWdmXDGXJS1zorxFRn6I8AofPZqykM80VKLDAyvgAbl+4P+AmaV99hEAwJ5tgT6
	 rH+n9vceN+8VcV+3aQRgkddCxSYNV5swU9Kq/B3ATbv8NILLL2xWHD0dTixa0sIVetDzA
	 MEZZbzcUIuCnzGxeoM8uANynnAoyG2eJ5aFfesDez7EiEPJeLAXUXrytfkxeNUPLtAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165651;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MIME-Autoconverted;
	bh=nET1WJNk3mHLCrQL6NVnuBWMpCe5epTVs5C8Nj7DNa0=;
	b=woJTY4/u2o1cmXbnwVSmwswAGR1HeunxRRQgPD2IRITu++UwgRoFIW9W688IIeVGPaHq
	 thwq36uo5nCjxtW6vZJH61k/U81BCoRKEDU+yEZzscZIRN5ARcYGpNah3lkI6NZPrdB4f
	 UE3tqTcpZt5U3+ZmmTxsgLUCPhtcBCd2wuQTieK3GYY2u/gISOXPAhpk1gS9NZQGetp3n
	 ePD0OtcXK2pfKDqA45nZWa/UoIXzikm0gx/n64pdsQUALgaEygIRbKQ0I2gUj8RfCEC3j
	 Sqc79JGi15ygYqdPmbxymv0ZWCk/erhi1KQernxm/2mfh4DahgNhlQjnm7PGct5hbgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=c127.dev;
	spf=pass smtp.mailfrom=c127.dev;
	dkim=pass header.d=c127.dev header.i=@c127.dev header.a=rsa-sha256 header.s=purelymail3 header.b=bYrUBH4i;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=Qby1ahSP;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE78606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 19:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE78606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=c127.dev header.i=@c127.dev header.a=rsa-sha256 header.s=purelymail3 header.b=bYrUBH4i;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=Qby1ahSP
DKIM-Signature: a=rsa-sha256; b=bYrUBH4iUsBPghbZDki/P3a8hQZmHlPyPkwCo1+aE65BNeEEifHU7dtas/0ClkJjmUUwOJf2rIGrzBo7LOJ6IupdxaBQfop8Q1jkhsxRUPfdPy8wD6o65WnvpAR9AELFGtOwmxxB7pTeABTg7ltrlChYeKdvQuE5cI/4kVc+SBacYi+eXdsezcJ97jAy645t9XG0kV0sjdhb2/Mu1OEejqdT+kj9vxM3v2D+JiFmmPWTxD1uSfqXOgOXXTvadK/oiEmmuG/oMdgvkcQTPO24BZCmZZRp5beoq7hX/6NykXX+mEzfra68LQD0N0Skr35xorNCSiWveED5n90WilxLJw==; s=purelymail3; d=c127.dev; v=1; bh=nET1WJNk3mHLCrQL6NVnuBWMpCe5epTVs5C8Nj7DNa0=; h=Received:From:To:Subject:Date:Message-ID;
DKIM-Signature: a=rsa-sha256; b=Qby1ahSPpZ5NkonjottD6WZtcXGrm2Ur5blwqmp97dQHox6qWoUirBypQoEwuzpTh5gv5eYEXLjnytS8UATZTYVp+goO+QT2DPt6a7I6VJzhJPyBwvYdL1usSwBs6BBIZ3oV6K/MhdP2CG36PM8uhOVkk3VGQqefE7TvhGEFD7o1NLDyrrDPZCsCGxYn+WocB9mOKFXumwbBxSkGODWVDWSeue4DW3AfBE7GUXuztHjjNzepb4PKMXLk0Ha2R1JbIr+1biul/6JIC+ET0KxLHcIdUpRPWNUA2SEHevg6Z7d64kWGfyPc933Aarx982GHGLhTWjYw1Ig4EBchBywDSQ==; s=purelymail3; d=purelymail.com; v=1; bh=nET1WJNk3mHLCrQL6NVnuBWMpCe5epTVs5C8Nj7DNa0=; h=Feedback-ID:Received:From:To:Subject:Date:Message-ID;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 322991363;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 08 Nov 2026 19:20:06 +0000 (UTC)
From: Johan Alvarado <contact@c127.dev>
To: alvin.sipraga@analog.com
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>,
    linusw@kernel.org,
    andrew@lunn.ch,
    olteanv@gmail.com,
    kuba@kernel.org,
    davem@davemloft.net,
    edumazet@google.com,
    pabeni@redhat.com,
    linux@armlinux.org.uk,
    luizluca@gmail.com,
    maxime.chevallier@bootlin.com,
    netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    gusfmora@gmail.com,
    kuncy7@gmail.com,
    fabianotassotti@gmail.com,
    gabonpivovich@gmail.com
Subject: Re: [PATCH net-next v9 08/11] net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
Date: Sun, 08 Nov 2026 14:13:05 -0500
Message-ID: <1e8da5e3-0d1c-4ce6-bb3c-4b9b7a5789a6@c127.dev>
In-Reply-To: <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com>
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com> <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Alvin, Mieczyslaw,

Thanks for adding me. I'm looking into this on my side, and I suspect
the problem may be somewhere else rather than in this driver.

I'm still investigating and will report back once I have something
concrete. Until then I would ask to hold off on patch 8.

Best regards,
Johan Alvarado
