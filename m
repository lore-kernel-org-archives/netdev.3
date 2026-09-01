Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D347ECC2;
	Tue,  1 Sep 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269148; cv=pass; b=dCnTtgTAyJTlwvq9UKh1GaocF+lykxpum2ZDjn91StbnD5sqkwyTbuE30+q5z+ELoqmYiS2YkBAwqRp3Fx6vOdJUeOnNKwQWSoJlm/l21ggmNFZCJwuYuo+Jb2xlre02hZGgd1YMjzq5oWFzZPc0Ir9qL+/W832L77U1Nv15WY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269148; c=relaxed/simple;
	bh=p5UnzM+3CyPXissVjrfNNF7wPx3GF9eMt//3kM8cW+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwyML4gu0bDlCBFtXAnDVTfShJFJcWOAd9SpYKO0D71ZACx8wsdAJLr5BHPa8bidtRn5oglFT37K5PiEfzd2N3gVq1qOOcEmuuBOwXVIcDd3Dl8Eib2RkF5oupIpZPyUC7yQXMFlEBxuzyBCqLaHcEZpEoh5aR9LatwN49B4TIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rq/UGbeW; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rq/UGbeW"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ61017D5z49Px3;
	Tue, 01 Sep 2026 16:20:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U/5+tF95qlb0i4WOja94VWT0wSoYK/3EZmn5Pucqagk=;
	b=rq/UGbeW9wsW/o36VwEpcGwXMT0GwuOfHoLO4ohZwLZuttMo6f+lWFe5QpVYzrAqgLf/1H
	eLaVF92GBxqQDuqRzhY8WCXaFNBz/SaJifHySzXtF0FQZ//sL+JRp5tVvjK5R/xxKPsXTJ
	I5siDVVyfSHu573LxyD7vIWP/P1RM3LEsaSi5o/DVj7JINsg779cw7NHNhaTEyPsA5Qyeg
	aaImveoAYByRJfIzgMS2M1AxKSiBJpiYIMckdyToVGCgJ6aDuXxVOzouHuU6CBWPX3ZsYE
	FbzsBkud1xVDljhteYbjVcUeJ72dUCUSxuAHQ2XuGkQA1fZcGT9antVTDuQ8EQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268821;
	b=mIlYlMM/2c8UJLlYkmbZLUyFZdqxIbT8D1Vk+aDS7B3y37d3z5mHHjbFfwzV6g4qLx9fLW
	qPrGk2aIyDa9p4+ZwLljx25OUUeSEDzghnl8kG2vcMca/U//n8t62rqNdsI9ArdSNh5PkZ
	sKicN7H2fhaoG7FWIaKrlKg4SyjcMF+EEHzD0AX/mvWxWz4ekVXAIz6NRWcktiGxuGSMZ2
	STBw07hyw6aSyD4T1i/lUeWPizPNpB3EvoTqNd5hyoe9p5tRTcFXsZasxZYPy3XD0D5dXi
	5jVOqXGJ+3Z/RsJQZa9NbNo/NwPFIiEEd9VoBbCNfbIwV3L6M74WlhTkfrpg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U/5+tF95qlb0i4WOja94VWT0wSoYK/3EZmn5Pucqagk=;
	b=bEuNfE77WCoKkhklO35kRn2s5oMyxpX6ok0GjyNf8GymPusJ3VCjySgjBL1LDzCzUH7SSF
	3l7zSXKgzmmgxHfNfqP0eM0JfcfhykHgUvUgTxA0UIxerSUBgzfwle26RlPQcZl37nWakn
	7t0KbjmnmxmHhADZGEkJHHEh7OJeSy5uFV4QbbZbhyuJKo5pjI0A5Urw/HYpiEp/vFapKj
	zdka2vEZt+Ml4xUhw8oO+MBcrpGayu7fV5HhIHagSuB5A6V+ZUfXAyz7l9k7BBq4YgRFq0
	McEWF2nWUpSlGHu/AfvA4khOI1Xdy4LdrI6SFf7iMU3wyE2KEDe1rApW+Ji1Ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 00/15] QRTR Multi-endpoint support
Date: Tue,  1 Sep 2026 16:19:19 +0300
Message-Id: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

First, I would like to thank Denis Kenzior and Mihai Moldovan for
initially creating this patchset. Without their efforts, there wouldn't
be any progress towards supporting multiple identical ath11k or ath12k
modules on a single Linux host.

As you may know, if you put two identical Qualcomm Atheros ath11k or
ath12k WLAN modules on the same Linux host, they will conflict and
neither works. This is a massive issue in routers, and to solve it, we
need QRTR multi-endpoint support.

I contacted Mihai Moldovan who posted v5 and he said he's been busy and
can't provide an estimate of when he'll post v6. So I picked up his
work, ported it over ath-next and solved the issue of cramming two
32-bit numbers into an unsigned long that can be 32 bits on a 32-bit
architecture. Mihai said he doesn't have any corporate backing and
doesn't care who implements multi-ath11k/ath12k support as long as it
"just works". Since it's been over a year from the previous activity and
since Mihai has been and is busy and said he doesn't care who eventually
implements this, I decided to "steal" the responsibility of posting a v6
to myself since I fortunately have corporate backing. If Mihai so
decides, I'm willing to hand over this patchset back to him.

Some of the patches may need dropping/squashing. For example, "fit node
ID + port number combination into unsigned long" fixes one bug on 32-bit
architectures but introduces another. This needs careful review. I tried
to adjust the behavior to my tastes in "use only low 16 bits of
node/port in 32-bit systems", and this needs careful review, too. Both
of these are candidates for dropping from this patch series.

Furthermore, "validate msglen before ctrl_pkt use", although it seems to
fix a real bug, seems to be orthogonal to this patchset, and could be a
candidate for posting separately.

Also, "limit endpoint range to 16 bits on 32-bit machines", "use nid
modulo 65536 in 32-bit lookups" and "solve the 32-bit unsafe use in
endpoints" are candidates for squashing together. I didn't squash them
yet, since I want to keep my options open at this point, to be able to
easily adapt to any possible code review comments such as squashing or
dropping commits.

Someone could complain that using a "radix tree of radix trees" approach
on 64-bit machines is overkill since a single 64-bit key is enough.
However, this doesn't work on 32-bit machines, and having entirely
different code on 32-bit and 64-bit machines would be a testing
nightmare.

I have tested qrtr with all of these changes, and with Mihai Moldovan's
patches to actually have two identical ath11k or ath12k modules on the
same system. Our limited CPU has issues with ath12k, so I have instead
tested it with two identical ath11k modules. However, Mihai Moldovan
created the ath11k/ath12k patchset in a somewhat non-optimal way,
leaking memory in some use cases, with an O(n) algorithm for looking up
the endpoint id where n is the amount of leaked memory. So I guess I'll
have to rework that entire patchset which should be doable. That's
future work, as none of the leaky O(n) stuff is in this patchset.

But first, before merging the multi-ath11k/ath12k patches, this first
patch set of QRTR multi-endpoint support needs to be merged.

Original description:

The current implementation of QRTR assumes that each entity on the QRTR
IPC bus is uniquely identifiable by its node/port combination, with
node/port combinations being used to route messages between entities.

However, this assumption of uniqueness is problematic in scenarios
where multiple devices with the same node/port combinations are
connected to the system.  A practical example is a typical consumer PC
with multiple PCIe-based devices, such as WiFi cards or 5G modems, where
each device could potentially have the same node identifier set.  In
such cases, the current QRTR protocol implementation does not provide a
mechanism to differentiate between these devices, making it impossible
to support communication with multiple identical devices.

This patch series addresses this limitation by introducing support for
a concept of an 'endpoint.' Multiple devices with conflicting node/port
combinations can be supported by assigning a unique endpoint identifier
to each one.  Such endpoint identifiers can then be used to distinguish
between devices while sending and receiving messages over QRTR sockets.

The patch series maintains backward compatibility with existing clients:
the endpoint concept is added using auxiliary data that can be added to
recvmsg and sendmsg system calls.  The QRTR socket interface is extended
as follows:

- Adds QRTR_ENDPOINT auxiliary data element that reports which endpoint
  generated a particular message.  This auxiliary data is only reported
  if the socket was explicitly opted in using setsockopt, enabling the
  QRTR_REPORT_ENDPOINT socket option.  SOL_QRTR socket level was added
  to facilitate this.  This requires QRTR clients to be updated to use
  recvmsg instead of the more typical recvfrom() or recv() use.

- Similarly, QRTR_ENDPOINT auxiliary data element can be included in
  sendmsg() requests.  This will allow clients to route QRTR messages
  to the desired endpoint, even in cases of node/port conflict between
  multiple endpoints.

- Finally, QRTR_BIND_ENDPOINT socket option is introduced.  This allows
  clients to bind to a particular endpoint (such as a 5G PCIe modem) if
  they're only interested in receiving or sending messages to this
  device.

NOTE: There is 32-bit unsafe use of radix_tree_insert in this patch set.
This follows the existing usage inside net/qrtr/af_qrtr.c in
qrtr_tx_wait(), qrtr_tx_resume() and qrtr_tx_flow_failed().  This was
done deliberately in order to keep the changes as minimal as possible
until it is known whether the approach outlined is generally acceptable.

v6:
  - rebased against current ath-next
  - finally solve the 32-bit unsafe use by "radix tree of radix trees"
  - remove checks of node/port being in 16-bit range (they may not be)
  - Link to v5: https://msgid.link/cover.1754962436.git.ionic@ionic.de

v5:
  - fix typos in commit message
  - Link to v4: https://msgid.link/cover.1753720934.git.ionic@ionic.de

v4:
  - fixed issues found in previous review round:
    o lock without unlock
    o wrong return value
  - Link to v3: https://msgid.link/cover.1753312999.git.ionic@ionic.de

v3:
  - rebased against current master
  - fix checkpatch.pl warnings
  - fix overflow issues with unsigned long radix tree keys by using the
    upper half of the storage space for one element and the lower half
    of storage for the other element, making sure that the elements fit
    into their respective storage space
  - Link to v2: https://msgid.link/cover.1752947108.git.ionic@ionic.de

v2:
  - rebased against current master
  - fixed most issues found in first review round (see individual
    commits), minus the 32-bit long unsafe use

v1 link: https://msgid.link/20241018181842.1368394-1-denkenz@gmail.com

BR, Juha-Matti

Denis Kenzior (10):
  net: qrtr: ns: validate msglen before ctrl_pkt use
  net: qrtr: allocate and track endpoint ids
  net: qrtr: support identical node ids
  net: qrtr: Report sender endpoint in aux data
  net: qrtr: Report endpoint for locally generated messages
  net: qrtr: Allow sendmsg to target an endpoint
  net: qrtr: allow socket endpoint binding
  net: qrtr: Drop remote {NEW|DEL}_LOOKUP messages
  net: qrtr: ns: support multiple endpoints
  net: qrtr: mhi: Report endpoint id in sysfs

Juha-Matti Tilli (4):
  net: qrtr: use only low 16 bits of node/port in 32-bit systems
  net: qrtr: limit endpoint range to 16 bits on 32-bit machines
  net: qrtr: use nid modulo 65536 in 32-bit lookups
  net: qrtr: solve the 32-bit unsafe use in endpoints

Mihai Moldovan (1):
  net: qrtr: fit node ID + port number combination into unsigned long

 include/linux/socket.h    |   1 +
 include/uapi/linux/qrtr.h |   7 +
 net/qrtr/af_qrtr.c        | 461 ++++++++++++++++++++++++++++++++------
 net/qrtr/mhi.c            |  14 ++
 net/qrtr/ns.c             | 316 ++++++++++++++++----------
 net/qrtr/qrtr.h           |  14 ++
 6 files changed, 627 insertions(+), 186 deletions(-)

-- 
2.34.1

