Received: from a9-9.smtp-out.amazonses.com (a9-9.smtp-out.amazonses.com [54.240.9.9])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05303B8BA4;
	Thu,  9 Jul 2026 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626247; cv=none; b=eIneRcR5LgigGbUNIsb9oCA2qaCC3fQZhOPLqMLUaOx15eHiq3dz9ooksOqUDqHh2eLW2W3ANNbZoB53Dx/QqwF8mRAdZlhMrBsjQrrDik6X0ImxTciVTn1U7ir431gdqXdkiVlDAIjfsW3xMPqDp9SCUKqNB4+8em+Dlo3pIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626247; c=relaxed/simple;
	bh=bFBlNI/NcJwt8wob6uBhAgxyRKbQPRuioxezGK4W3LE=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=GcypIRqItzOX18Jp105ulWGrvMraCGrDe7a2pl7QMpXIemimNTLwZTswUX8n5xieHfM9s7dr68W5S+d5YztikVYZkziWSivpaDBnD2lQu0Ri+T7AZ7glNicdkgN0nSVsR1cX3DoyaCJppWpTgcoM6pSHQXDjkNpu8U6SZY9M2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=koLDdl6V; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=qZBq+M8L; arc=none smtp.client-ip=54.240.9.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b="koLDdl6V";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="qZBq+M8L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783626244;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=bFBlNI/NcJwt8wob6uBhAgxyRKbQPRuioxezGK4W3LE=;
	b=koLDdl6V6FfbF0YzNaZ1ii8w72fGoUMvDWtp6zufwAPhmmm8YWq+cxCSrJ3KhPA8
	yz4nSRQ7Gpuz4CCUubQZoOsSOKJMiSHZ+iEpID1VUUMPptAf2cZ3ELEOFazTZoYlLmL
	bFg52HEWuITLAQ434sWNTtXVi53pJQXQ9JyAHcdI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783626244;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=bFBlNI/NcJwt8wob6uBhAgxyRKbQPRuioxezGK4W3LE=;
	b=qZBq+M8Ly+FodHoUBQIhPwFX5eu+6LekWE5QFwS+wp2fRLjMbn89CNB0tqzAySql
	xUN/LAfcLbhb834Hjop17kiOBGNgtlET8zxKBtLigez3dnLMwedg08GanPTboSfdOqR
	ou+ZQDOR+jidkTQFZg/x9mQOFGqJ6aUfjitqYBIM=
In-Reply-To: <276c436f-696c-4301-831e-6a79e4756905@yahoo.com>
X-Entity-Ref-ID: <20260702204648.276112-1-contact@c127.dev>
 <0100019f24962e49-10163ad6-22fd-4528-b8f3-75703cfd80dc-000000@email.amazonses.com>
 <577055ac-9378-4d43-9ff2-1a1dd17ae9dc@yahoo.com>
 <0100019f45cc4fe2-2464b68a-dfcf-4e93-9bfc-8445370d8e3e-000000@email.amazonses.com>
 <276c436f-696c-4301-831e-6a79e4756905@yahoo.com>
From: Johan Alvarado <contact@c127.dev>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: dsa: realtek: rtl8365mb: add
 HSGMII support for RTL8367S
Message-ID: <0100019f48689fb7-326dd0b6-f9ca-4cec-ab6a-a873c6223363-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 9 Jul 2026 19:44:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.09-54.240.9.9


On 7/9/2026 5:02 PM, Mieczyslaw Nalewaj wrote:
> Performance degradation =
without setting these registers can only be
> observed in HSGMII mode with =
simultaneous load on multiple LAN ports.
>
> This was noticed during work =
on adding support for the Mercusys MR85X
> router with DSA to OpenWrt: =
https://github.com/openwrt/openwrt/pull/19445#issuecomment-4505613294

Thanks, that is exactly the measurement I was hoping for. The ~1020
Mbit/s combined ceiling reported there with multiple clients sits
right where the 0x1FFFF reset default (~1.048 Gbps of wire rate)
would put it, and the jump to ~2 Gbit/s once the limiters are raised
settles the open question: the reset default is a real cap, and the
"disable" wording in the vendor comment does not match the silicon.
It also confirms why neither of us could see it with a single client:
one 1G port never reaches the limit.

I have updated v5 accordingly: the =
code comment and commit message
now state the cap as observed instead of =
hedging between the two
readings, and patch 2 carries a Link to that GitHub=
 comment as the
reference for the measurement. I will send the series =
shortly.

Best regards,
Johan
