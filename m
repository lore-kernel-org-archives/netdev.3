Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456515;
	b=TkZzR2IlS+ulAKW7cBjCDalqVty4WPWRtthVKEP4rVW8nERBCR4aeqHBJ3YKbeUnv2ws
	 Kq5A1mMx57fb5imAfHFSdYsltiXt1+aeboaymkZ7vNQfF6BmjsDmvd3C0+5Ka+HLiBdW+
	 TDhDdQNpxqEyFkdoQa/KCwNZCS5hCgOD0v2JWZjKmsRJYQ3ysSSdxkrOTEKcf3ZLLC4XG
	 BC/3H7vCMRk/Vb38K1Lecoym3KAIU1D8VDFV/UTXYRxCIOU0FyRx4T080L8Qp+H2I1WdE
	 6D2EPqHLOQDMZTAPbQyndATj3sMBZp18aBuQT+XsSYiTu2aCDiraVnODwkKhOrJ+fhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456515;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=hITz8gs0faWLxZ/glASJObi4AjjcjXrRjtX1RaulOvA=;
	b=SG9sTItkCBdonbUQm/zMhpICoSnCRRk8ePRCTjcIfzQTfkrcTJ9zPqDdQT593vu0nEku
	 am+Q/XAqMzSOmPguXzEqBfgX0PEzxzOFSgWacB50E4mOBJQefxiBGaLUldvD7y3N8MPSA
	 V6JxYE/qG9bqmdPdzjeVVqvVfdwT93Bs1v2ekPcFg1oByy+jj0Ltr6gvCgxXIGXry+9+m
	 ozgVPzDe7az7rSMrK9800+SGqKDNJiR24rDX7pQ6oTu7fI62PSfKN9N5+gUPKwggZE+W1
	 6irZTXtLtuD3j/a0CXEzIt9bOQNtNPn9ochrQM9aiuV6x3GbzUH8FOUIM/gc/T8y8TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=csSyvirw;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6F606A31A;
	Tue, 20 Oct 2026 00:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E6F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=csSyvirw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hI
	Tz8gs0faWLxZ/glASJObi4AjjcjXrRjtX1RaulOvA=; b=csSyvirwUcN2OOYkK7
	KPshFZYZPY2PK1JLtGZL16iEnYDzx/k3nF/yUPbMMcxxExooNQGqT+xHJ83GeZgh
	4faz+PM8v+RBb0SLsCcvlCbKY73UCM4kR7+kC5FFN//gZsgX5l61hHfAFELsixM+
	C7KRd5HEuY/3I3SeoikhChIrc=
Received: from shaos.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3HZktt9Zq616PAw--.45303S2;
	Tue, 20 Oct 2026 08:34:53 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: sched: em_meta accepts shifts outside the integer width
Date: Tue, 20 Oct 2026 00:34:53 +0000
Message-Id: <20261020003453.1010097-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:PygvCgB3HZktt9Zq616PAw--.45303S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury5Ww4DZFykArWDZr45Awb_yoW8tr1DpF
	yvk3W3JF9FkF4qqw4q9a1UX39Y9wsakw15G3WkC3W8urW5Kr1YkryFqFW5Wa47Wrn5G34Y
	vFs0q3s7W3yDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0OJ5UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8Q1JV2rWty09hwAA3+

Hello,

em_meta accepts a user-controlled shift exponent in tcf_meta_val and meta_int_apply_extras() applies it to an unsigned long without checking the range.  A shift of 64 on a 64-bit kernel reaches C undefined behavior in the network classifier.

HEAD commit:    fe2ec83746e501645709761605c2464a44fd2929
git tree:       upstream Linux checkout, local branch master
source version: Linux 7.3.0-rc4-70-gfe2ec83746e50
compiler:       gcc 11.4.0, GNU ld 2.38 (from the kernel build banner)

console output:
https://gist.githubusercontent.com/shaos26/4d0a6531f00fd3baeabe040993953402/raw/1677be670d3d39c0054b4ecd40c69b375630381c/console-output.txt
kernel config:
https://gist.githubusercontent.com/shaos26/4d0a6531f00fd3baeabe040993953402/raw/e47da1b0ca0ffe6d0ac3a988e2c30c7eb634ede3/kernel-config.txt
reproducer:
https://gist.githubusercontent.com/shaos26/4d0a6531f00fd3baeabe040993953402/raw/1f5f1944a0a8d87af969b58f80c4dfb10e50eca2/poc.c

Build and run the standalone PoC on a 64-bit kernel with UBSAN enabled.  The program creates its own user and network namespaces, installs the em_meta filter, and sends the triggering packet:

    gcc -O2 -Wall -Wextra -static -o em_meta_shift_poc poc.c
    ./em_meta_shift_poc pos
    ./em_meta_shift_poc ctrl
    ./em_meta_shift_poc nofilter

Two fresh boots with shift=64 reported UBSAN shift-out-of-bounds in meta_int_apply_extras(); shift=8 matched without a report, and a no-filter control was clean.  The observed effect is undefined behavior and a wrong classifier result; x86 masks the hardware shift count, and no memory corruption or privilege escalation is shown.

Impact and prerequisites:
The demonstrated result is kernel undefined behavior visible under UBSAN and incorrect packet classification.  UBSAN is needed for the diagnostic; the current evidence does not establish a production crash or a security boundary violation.

Validation: Two fresh boots reported UBSAN shift-out-of-bounds for shift 64.  Shift 8 and no-filter controls were clean; no memory corruption or privilege escalation was observed.

Thanks,

shaos

