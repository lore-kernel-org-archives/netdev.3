Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414609;
	b=Ut/W6EFo+UvYenGPzWbPqGm3MiOllcqh8r2u/KG76LHj2JAxKf3ToMLLXed42zD4W4r5
	 PLmqOuhqcSy27glzddhdBCMJPCVf/txMYaDoJUjv/g+bQrHG/tgHwcKEvbisqvwvyEHTd
	 T8uJmKVyHmNmaJCxAzZSIQAHCT1RSAUc4yZW1wn4xBNAuIG/ZFRZ3BLthTbIwKXqw/yf8
	 noH5uvfQScAvmFs5PN5Hvph1fTyjaxXq18HQpY4abDIXHqHYEPl5sIxDsj380l7mWv/6C
	 Lze5aZIVQW8UExJncDQJruJKLdFVz8LhMXNcMZ5x4voLb8UWTf3fvagawr5lggiF+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414609;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OWgy29W1DVwDzpM+q0XqDCZor85gzBEbXGqQX/vaW7M=;
	b=yEdALB7GAbV3GWBsKE+HSaD3i+wvGMVj2co8z+EMfaGQsxkf+HybmxdkTthThO80DAy3
	 zqqpVu5GbsFMa7sQy/eFrQn8G77ZambpfjdtzCCGwjrsN7mTrBZgwy29f8T/kgCp4vPd+
	 zFePkWiWDxPx4F0g/L0W0gJi03DOx+TD9lSn8hTqHTrG4hVwtGeNXw7hvEl0YjmP+Z1cf
	 3qF7SxSSqMB+x0oVxRzYQk0aAXjjYz84HRCDvJ8dVvuN0XAZTnlC2EXY3RPr2D/+6ulHO
	 pRisrwicC4DPY5yq48R8rHsBkiMy21B8+Pb1Cf5pvk/t03ukKI5vjQd1HBeip9jzYNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=rNUwdaQ0;
	arc=none smtp.remote-ip=203.205.221.149
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505F606A320
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 02:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B505F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=rNUwdaQ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793414599;
	bh=OWgy29W1DVwDzpM+q0XqDCZor85gzBEbXGqQX/vaW7M=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=rNUwdaQ0bVVKMcOXiUjbFlkoLNh+dKQwGK6ZlZGzI89R3mYcj6WmYdssANkQgzHg8
	 7Ys0memCAohA1SPiAXHpRU6d21eaiz/eMaKsXuqyoM1ESdDaLtnKazHxS4br0oDcJF
	 X/qcti2rVEuvxNp5uvc12309CRX3c12jFWt8O2YE=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:5da5:a99e:d3a2:d604])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id AD18E89E; Sat, 31 Oct 2026 10:43:17 +0800
X-QQ-mid: xmsmtpt1793414597twzm92l98
Message-ID: <tencent_CC4F6D712E4731FC516800714E372A6DAD0A@qq.com>
X-QQ-XMAILINFO: OMLxJehTXM6U6xyfJA72s25R1NhE6MT34N0JVOFBquAvu9pBoBnDeJz4nlKFtT
	 2XiiTDGzsvzhYvxESg6aDhPrUcLvGZXJCgJh0B7+Y9dGP7qeTZYgxdONGApW0tm0/CRZ51+QmUR/
	 Afik4BRL0+qpO+tCPNkYv7tZMrs2n1DSNJa4SWFhqgwpm6Y80raqiWwzcgtdfKCdaWRrv9Np+CgA
	 GA857jfXpHm5F5dGZJo0OggYk5IcwPMScHayYNAqzpsbBvcMlOo146tmUli3jy9qNCW2YN98u64s
	 q60z5JgTyeDn+jM3ptI5yXWFsE6a5P1A5NgguuXUb2BZIldtWQGUQSTYsj0cWCuCjhje0c0AlxKP
	 5706U9D83nUq/XeS5n0UjOQlAVkdXja5iepur/nxBApqHWXlUaWWlAnWriKq00dT1t1cOTGMEuL8
	 RxsDos2KzoSOxaKFsn/NtYeCcqnLvs3n4FapQGJ5B7Y6aucWj+U4MFCGA4N7W5tR17QLeaZDL6Iw
	 c+t3Stsu4Lk8Ma7PEBmAUzr2h9SEtm3H0DdiM2wQkiDVHQEPFgXwBrE+ycf/FsrIyCQZZDQO9psd
	 HmlRbpceeb2BsJf/TXnCG5T0PI47cE7MQ8YHuVHRRXVJAKK1ZJ3JQX+Wu+GaGLeg+ojW2dKBJ6FH
	 UMo/J3SXoGToI7eTpj23W9Oc6HvaAIuuW8sSivHy0FwmaoDiR8Aa6SnI3URZm/7T0cd1fLrNV5Cd
	 gcHaq9XdJXiwdNEh7ia/jYKYTD8L+NvvYlTPA6XI8OfUT7a6Sn+/ms3ZKXuzKRz5yFd293520zY7
	 cbBn7xm8Anu6FLvOdq5i2LiEHFqY6Hbg0sMscydDWGkNOFsO+g9iJwk02KiC3U2eRvg6ViP5Ex1X
	 GOrclpGVRXyxzPWlSCPtkZoGSxAjLEX7plyue01RvzCYjZrSMVJ9hofue/TgV1AkdXg1mc4JM3Bc
	 3Munelwel74UP6ggruFvVHQX488A6DJBdsS0WRyiGZTxP0S1r+FTECdotF9e/gc53VMhnzQ+4lq5
	 OQ6JZI01ky9U5NkdQ9uZ/yjkS/JHZGEi2wfqWmSYQlQ/1nRvNll9ac8dABQ7Q=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC
Date: Sat, 31 Oct 2026 10:43:16 +0800
X-OQ-MSGID: <20261031121001.memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179335970863.3134.5191378244494717635@kernel.org>
References: <tencent_F5633A48A97A7D712B7DB98CE1950213C805@qq.com> <179335970863.3134.5191378244494717635@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Confirmed -- the analysis is correct. MXL862XX_API_READ() returns the
firmware result value on success, and a CRC-valid result of 1..1023
comes back as a positive value that passes the `if (ret)` guard,
skipping the bridge_id validation entirely; the callers then store that
positive status in priv->bridges[] because they only test ret < 0.

The same return-value pattern exists at the other ALLOC-style call
sites (QOS_METERALLOC, EXTENDEDVLAN_ALLOC, VLANFILTER_ALLOC).

Planned fix for v4: treat the transport result and the payload id
separately --

	if (ret < 0)
		return ret;
	if (ret > 0) /* firmware reported a non-zero result code */
		return -EIO;

and keep the 0/0xffff/in-use validation of br_alloc.bridge_id on the
ret == 0 path. I will cross-check the firmware result-code semantics
against the GSW API documentation before posting v4. The sibling
ALLOC call sites can be cleaned up in the same series if that is
preferred.

pw-bot: cr

Best,
Zhang Hewei

