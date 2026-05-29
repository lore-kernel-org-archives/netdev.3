Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D03F0ABD
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079357; cv=none; b=d7oZoV0wWcLkT+fYOT72wiBlOUPlLiPLQOrMdYxOEFc6Tk9SDI5EKisDL4YLLhu1APDCl8BjwL9C8C+hIMC9YoiB7htLqSzXedT2RcEd+J6GUfWsp6UqGFbXpL/5OozX4d3GafxtYaT39nnQqUmbHs8DhVDUDvH5/ZVU1xv9AQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079357; c=relaxed/simple;
	bh=BjWqTyDxUdfqE14VFV8iw+Ji/gfyO9phtRw98i7w+W4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AnygP+5kqN8uwk8m3Y8Z7jczIdlaaod4vYGem3Dsjva3xtawHtmibdOPa/6oxLQU7YR7vWP4Sl54LxBZueXuQ+srJvuscKjZngh4HybLinLl09aUjBq1VPUn37oqQflTfPjHwEM4ylxXV8SJEfB/pR1kS2HbwQN1kv6ro2CBfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Zef24QeX; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Zef24QeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=arxro2oaarh5havr3xqobzkzcy.protonmail; t=1780079351; x=1780338551;
	bh=K4HabgLRlspjLKXF/1Q9wzXeGtbAyDxSqL9Ju2E8DMI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Zef24QeXyhjaeZyqqsMdLsylngM9OMyGPQRhbt1BgaRjNE34VezaGvZcF0tFZud3t
	 MGT4BswqNXQi0vaafhhnvF76MxWqQITVGsUxCBr9qwThJhPTANPppfFqR9JbsCD983
	 TTUAoQ7MKp7Yqd7gv4aHblMp72HkfgyivhqwbKZoj8XpawQhRGUV5E97dRb/UeAsrs
	 T9ULpEZBUe1jNWrAjg/8aOdzIbidajIV9gZMI+XbsUW+aKWXXUOD9eaO9vMyYaxJ+5
	 b91WorbDAh8DHNHfEXsj5DomPCm203UHCCTeMz5EUw0jFlPYPg+5VVB4L+nAdSfER+
	 4wIraCFazfWdg==
Date: Fri, 29 May 2026 18:28:58 +0000
To: =?utf-8?Q?=C3=8D=C3=B1igo_Huguet?= <ihuguet@redhat.com>, Stefano Brivio <sbrivio@redhat.com>
From: Tj <tj.iam.tj@proton.me>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Fernando Fernandez Mancera <fmancera@suse.de>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Linux kernel regressions list <regressions@lists.linux.dev>, Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <ahnaz3ppxyVHl3xB@mail.iam.tj>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 5166abbb1ff849044137cccbb7fe39bb5fa1386a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I believe I hit this on a router using Debian 13 with v7.0.* kernel this we=
ek that
uses systemd-networkd to configure IPV6 RA and prefix delegation after
moving from v6.19.*.

Symptom was the router could no longer reach public IPv6 addresses
itself but forwarding was unaffected.

The ISP (Starlink) provides a /64 prefix via RA and a /56 via DHCPv6. netwo=
rkd
allocates a static suffix address from both to the WAN-side interface.

I discovered after much experimentation that instead of the usual /56
address being the source it was choosing the /64 and failing.

Router uses policy routing so my work-around was to add a rule so the
/64 address is added to the WAN interface's route table.

[RoutingPolicyRule]
To=3D::/0
From=3D2a0d:3344:aaaa:bbbb::/64
Priority=3D30100
Table=3Dstarlink

The WAN interface config for  RA and PD is:

[IPv6AcceptRA]
UseGateway=3Dyes
UseDNS=3Dno
UseDomains=3Dno
Token=3Dstatic:::ff
# when RouteTable is set a table name is explicitly required in any [Route]=
 section without a Table=3D of its own
# names defined in /etc/systemd/networkd.conf.d/51-RouteTable.conf as:  [Ne=
twork] RouteTable=3D
RouteTable=3Dstarlink

[DHCPv6]
UseAddress=3Dno
UseDNS=3Dno
UseNTP=3Dno
UseHostname=3Dno
UseDomains=3Dno
UseDelegatedPrefix=3Dyes
PrefixDelegationHint=3D::/56
## asked for in RFE https://github.com/systemd/systemd/issues/31566
##RouteTable=3Dstarlink

[DHCPPrefixDelegation]
Announce=3Dfalse
UplinkInterface=3D:self
Assign=3Dyes
Token=3Dstatic:::1
SubnetId=3D0xff

