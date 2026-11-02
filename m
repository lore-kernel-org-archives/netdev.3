Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628604;
	b=IZrIWwEN9yD0mhxtfw5X5GD3S/7zTLEVXL0CF/ea7dRGw+pE+NDvLDUa4IxoiY7bdB+M
	 Dmv7eSJ1mrntzqrbzI/KLcUQEUrPeXFN3D92dEyzijiNeghYhazSvCg73C9gfQSJaHS9/
	 7nMtXBKvUwF57iC/X1xzLOybxOmo3tB+RPvHDgAY3d3a3M+9ngpOH1fitFHelnKzS3wpJ
	 VuZxSzUzlfoxhGINrJVhWQiWURqPU9YcXPrkNSODHOuRJrHNR0N76MydU3bsf2c5yWC0u
	 XZoGJRi0t8S8ti1WE+Fw3//+0jtgGKHGvjdpkTIK2N0iT79b6FvQtCxgYi2sDnFxIMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628604;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=iGMhxBUb7ck8o3WMUjdrYAj4HXk/JXVPVBtzwXCcJN7zRPuNwAjrd3NJIuOCtzAP89pr
	 u6vihmVxqlFjL+3l0BAiWSYKBUaqxyyxHsTnkq5NYg5ANKB/R+lG2v3XM+8KCbCm2f7yL
	 iVUwkk8JfECZc7ezPG7GHu4D6yEGcK3siOL6V2IK8caD4moWDkckcQ9wrLoQ9T3qnp6IB
	 8EP7sUU7PHOcYCL+VLTfu1Y7mImxoUf9PDJjhzq9goUF+oCV6ZDK8vGes0dMwAckRRhqm
	 Yo/6DvT/biMz/4vYKdv3YACGzLTKyptMgtPXw3p0HVmvPZxrKW49meOABVf1j3tbPBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEEeIrp+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D7606A326;
	Mon,  2 Nov 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEEeIrp+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1711F00A17;
	Mon,  2 Nov 2026 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628603;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MEEeIrp+r9gCHAymw+ZMfHV4nWa6e1vbX939qfcKvqP6I7RFupLSBeR+PnEO1rlri
	 n9v1r6fDyPBJNE6eDu9nKF+EKLZ3qx34s5CZ1RgHglDhOe9V7D7+ddOvsTBix4+bDr
	 tnjb7Cse1XDBjo/8VItiVCC/gHTxTFXZpRD25CqstQelGIfPyOUAeDqkpOAZBmvwkA
	 OzOIh+8bwzIHshvvwURe/NTHucIZFFPUIuGYHOwX6KOe50eJgFx3pv3MqFg4cubq4X
	 ZtIUJW1eA9nD+CxohqA5mm7FjGDlaAhrVe5DmFk3IBfngMICnz15rSR5lSI6wb7iay
	 G7cMZZiMPCGsg==
From: netdev-bot+sinfo@kernel.org
To: Dmitrii Iakunin <zeil@nebius.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 NB-Core Team <NB-CoreTeam@nebius.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: 
 Re: [PATCH] net: validate checksum start before software fallback on transmit
Date: Mon, 02 Nov 2026 14:10:02 +0000
Message-ID: <179362860283.3286.3148983179683113131@kernel.org>
In-Reply-To: <20261102140633.42564-1-zeil@nebius.com>
References: <20261102140633.42564-1-zeil@nebius.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
