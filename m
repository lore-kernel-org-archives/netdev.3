Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707778;
	b=wPZEAMWPInsc4EDUJ4knJC9wEW1Pyf/RKNLtIf1A0YU7bbWEbv9td+DTbmdu0epHrm7A
	 Bz1akD69krWD/kt2vKZM0xz9PJHKOnl7q1RbbXhdCh+NbAqd0XeCydPBRAVl1yeysSTe+
	 Exaq/jQVbkWsDfjkrhs6MWvV/UXoEgWkRCL0mSUSaGYwhowrJS2egOHbvuD4xR3hajxuK
	 riz7tJUiORjNlaoRCbCLynNlD/jElRFMmmJL2ZAEZg1XHCl8/1BT4PyFcjcFfpZbi6eQV
	 r/VgFVltTfMdw0/3aoPOwQeAOVkpHJ1geTDCzueou1FQbFJ+qdrKOfPMJU8a3Bx3afQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707778;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=qOgVcaVCfVDurCdKkOzwU6BX+3zAlyWvZ5jp4m/3mPw=;
	b=aF2jJ4G/tstsQ9WWGKyvT5UFrse01kgEgdHGZuFvx2FVWA/4y2vjxIMmQJrtpIYBK6yp
	 FAQxDIV24fxszsEo91MKcOqu9WzhGvo5pSM398Ggt1wJErSDvryg4JPEszcJ8ZRswrSYh
	 Xao4Q+d1/q+LhVpo3U/H8EbFttgxXB9CgXyRFMRtEAubT0D15O5tnmH3jETZ5vQ7DngLr
	 /jTS6jmINucCxgoXgFOEMjsw3Puf/+VM5nxgfbgi1OmZIzhho7Iz4OOIXYpU8fVi/zRLQ
	 rNLMu/KCIpwCgkm5gKmaZn2MoLAvLD+CxdLSixrEWzZxubN3BYHwcyomXFWn142Vyng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ip3Fe6JO;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1599606A32D;
	Tue,  3 Nov 2026 12:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1599606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ip3Fe6JO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ip3Fe6JOQaCT+v808aulAvX66nfYRcwickWpP+CoQfXLol5xUKo4DlI4WqMbcO/iokObv+kHf6AEC
	 EExEw/5c1yr0vpidgkIfZ+HpC7TKJOysIzc/CvhatfhKkY46t/wrK7HUbI2JQ/5zNHnB+9q6Wnj1Dy
	 H+Ay0osxhaKS9GrM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae9cefcbdc-6136c;
	Tue, 03 Nov 2026 20:09:34 +0800 (CST)
X-RM-TRANSID:2ee66ae9cefcbdc-6136c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from dsh.local (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96ae9cefdd64-f8da8;
	Tue, 03 Nov 2026 20:09:34 +0800 (CST)
X-RM-TRANSID:2ee96ae9cefdd64-f8da8
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sinfo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped
Date: Tue, 03 Nov 2026 20:09:33 +0800
Message-ID: <20261103-adin1110-clarify-1-yuehongwu@cmss.chinamobile.com>
In-Reply-To: <179370682903.488859.10553739131009732027@kernel.org>
References: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com> <179370682903.488859.10553739131009732027@kernel.org>
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
X-Mailer: git-send-email 2.43.0

Hi,

Here is the information missing from the changelog:

- How the issue was found: during a code review of the driver that was
  assisted by an AI coding assistant (an LLM).  The assistant compared
  adin1110_net_stop() against the bit definitions and the mapping used by
  adin1110_port_rx_ready(); I then checked the finding against the register
  semantics used by adin1110_net_open() (IMASK1: 1 = masked).

- Triggered or theoretical: theoretical.  I have not triggered it and there
  is no reproducer.  Expected symptoms if it is hit: on ADIN2111, bringing
  one port down masks the peer port's RX-ready interrupt so the peer stops
  receiving, while the port that was brought down keeps its own RX interrupt
  enabled; since the interrupt is level triggered and
  adin1110_read_frames() skips the FIFO while netif_oper_up() is false,
  pending frames keep re-asserting it.  On the single-port ADIN1110 the RX
  interrupt is never masked at all.

- Hardware: none.  The change was not tested on real hardware; it was
  compile-tested only (CONFIG_ADIN1110=m, x86_64) and passes
  scripts/checkpatch.pl --strict.

Per Documentation/process/generated-content.rst, the tool assistance is
noted above.  I have reviewed the analysis and the change and take
responsibility for them.

If another revision is needed, I will fold this information into the
commit message.

Thanks,
Yuehong Wu


