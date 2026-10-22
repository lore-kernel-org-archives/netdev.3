Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700072;
	b=M/lGUP0LEH1cVqvKVo7wspGoZliqvH/UVxycUWTcfuE9MumOc1Q1ubkcEcd+NqLLNBSm
	 FqM4t/3AkZ10MzrJ/WFkemZOMsQln+++rJFwSnm+2mvIWfJixJVzcTEaez2GykGBEx6Yi
	 pg+9WngXN22oOYjI3a/xP6LBXDdnP/RwsR4s5Zgui+6U81Yc1eCjtQAKgpVPRwxHA6x6n
	 Ni1HEiAFtM33MGO018vlbZqhgI0qZxQlDXV0jnbfmoGCLzmzvD+ChEzuPJRWD8otdiAb5
	 IskSrydwoo7igm/kgdfCHY+13oE+1wryqWPyw5XrNIj75jTLT1mXOk5kmoJT5GyEOKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700072;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LAPtyJfEMoCnzw9imSIjb9889rqZ7TMiB3U5SmWB/LY=;
	b=wdR+KAM6LI3Xf1HbIEPIDTbH+tMZ1J3XHPM4JdBz5Ey/ZESPsexHAbsRRu8kw3Fmv9dV
	 klFML/ZqylPLjWW3yW9W520eQPCu78yYw02qClcHHDN1jSwYQvNPihgNFhiccEeFK+hfE
	 vkuWPb6eZQJiiOWRiZeqyw0nA1z34ptWqpH7NdH2REJK5fqAN3XLF6ITHyY5G5IpbjX74
	 qCmWk2frTZGuRD7vP4jSHokXJ87xSf12+Ou8Yh7bJs/fTnRHO+BONxbyQIvL2YcAsnh3v
	 af419msQ2c0CjLWi/IIQibFt5cCBUnXklz9DySMyZhGOQpR/EfpsUs3raSHdBZUSaMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Ip6eSAcI;
	arc=none smtp.remote-ip=203.205.221.202
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F008606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F008606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Ip6eSAcI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792700062;
	bh=LAPtyJfEMoCnzw9imSIjb9889rqZ7TMiB3U5SmWB/LY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Ip6eSAcITahWxT8Rv2VPbIg8BW1OpIFQETjo+JeHWwQZeQ0Fwdan1NZ9+oFUPoTD4
	 snPw1A8LiiWMndpqspDZNTht7WNaupCYGIUc7AIAU8AfdA9E69pTpcg0RfkJpEBqNb
	 Umi0kfoC639CLKECSRIn1nwMgNfa1ZSCfMlq2caU=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 3943CEE7; Fri, 23 Oct 2026 04:14:20 +0800
X-QQ-mid: xmsmtpt1792700060tafu7is3n
Message-ID: <tencent_1450C834A812C63AE916E5F22AC31A453C06@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznNAJO8ZeIu/Sk9j9qYfm/wPfLZaqn8t+6EYPk1IcRRSIzhSDlGi
	 iDZQhdrWF/cFXPfkwyyVTAYXOkd5KU+1QE+YDjjgkk87opAZHEL/HJuVWAtpr8yniJgZOc1k/DpO
	 XryLob27DY1NRUwVSy/QOrO57p0dij4YT7RDf6onUznw6NYQp0v+bf8kzpG4aj/aMgptyc0UMO/K
	 9cNDfo1Zz4DvheDNu1MvIibozs79K2NLC8id79BKB2EVP83Ok6B8Am065s92E+HEyMQWfOs6HST2
	 iAIkrguE8rr1lGClaxq596x83F/wm7hDH5YOfZmt18xzJ5ZurEhR9IHPJrxtv+DMF3f/luLKleUQ
	 QwtSwGJigQ1SDU4OKB0iZeKtrhY4wPk3kIvr1DWY7ljOV7aoLxH+h6mmOUykr5/DQwObRODCiEtk
	 NLssogMUXtjvQ7bO7OIOEcKNpWgoMt2NCf6C/2MKqayc5XLfJabxgWVKKH36DDLchu5TE19jDq0R
	 M8bxxIku8LQJCmuhDhprpc4L/RDxG20PUM1JUkAwCW0i2DRzTO6RC1j+tR/TpYk6pcHBMw0MrRma
	 Szw+8d1M2sZUta1Hes0IIDOL2u28+WJzZYiPZC4ept+z5mhLbXZC6v3+53Qcv8MqVc+5/JkeH9no
	 gM39TCV5obX2Yu0laivhFLi61Mb03l8lWUthuBMrh7vSvTTfWH9qFsb7HQUjMy2jxqO5hBx2Vwal
	 dnnv/0VmKH1Y/JDDOdq0eLpypVeDfUiHN8PZNY3tcJPVTLv5LnqItD9LW2EwiX7UAq7N2Q/lacrU
	 5k43mqKiQ0rn0K3boEo3cVUlOxHIE41UAQjm4deoqCbviMW73THG2I7IVIj/9hjbJ1KAhjaPUe+y
	 IUZEv3D+0Fs1wF7z5JX2LXRyI2qL7kIqLAfnU/YEW40OrWlvh+Rp4RNjSu3jxYnyQeijgFojQVB8
	 AOsJg/mqJGNiAqVhVSyVFwO6K6twSXwQLv68nBM3e7YW/o7jJavWWmNjlGq8GE/kY+H7fgA6hXGO
	 CWgStxDl1HfPck2ECcL6CPcigY/Dc=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mxl862xx: bound FDB dump walk by table capacity
Date: Fri, 23 Oct 2026 04:14:20 +0800
X-OQ-MSGID: <20261022201420.81861-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179269966728.3290.2627206928544645649@kernel.org>
References: <20261022200425.80147-1-memoriaru@foxmail.com> <179269966728.3290.2627206928544645649@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Hi,

Replying with the missing context requested by the bot:

Discovery: both issues were found by manual code inspection, while
auditing this driver's handling of device-controlled responses (the
MAC table walk and the BRIDGE_ALLOC reply).

Trigger status:

Patch 1 (unbounded FDB dump walk): the loop mechanism was reproduced
in-kernel. A self-contained module carrying the verbatim loop shape of
mxl862xx_port_fdb_dump() (device transport stubbed) was built against
the official Ubuntu 6.8.0-71 kernel headers and loaded under QEMU (TCG,
unmodified official vmlinuz): the walk never terminated on its own
(100M iterations logged; a real table holds 4-16k entries). The
reproduction is fully automated in Docker and needs no special
hardware. I do not have access to mxl862xx hardware, so this
exercises the driver-side loop logic, not the real device.

Patch 2 (bridge_id == 0 accepted): reproduced at the logic level in
the same module: the driver consumes the firmware-supplied bridge_id
with only a ret < 0 check, so id 0 -- which the API header declares
unused (mxl862xx-api.h:243-244) and which equals
MXL862XX_DEFAULT_BRIDGE (the CPU port) -- is accepted verbatim as the
port FID, merging the port's filtering domain with the CPU port's.
Whether a device can be made to actually return 0 is unknown without
hardware; per the API spec such a reply is already protocol-invalid.

Build status: the reproduction module compiles and runs on the
official kernel; the two patch hunks themselves are small and
mechanical and have not been compile-tested against a full kernel
tree (no mxl862xx hardware available here). Reproduction code can be
shared on request.

Thanks,
Zhang Hewei

