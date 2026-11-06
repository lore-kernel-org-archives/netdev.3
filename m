Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949970;
	b=JlO6atguQd1vD9K2v0K+JpQMuqzt48rQpNOkvYSGRSlUUhMioaiz/xwDHR20AshsLUdc
	 jeHykBgjO419yWvF0rj7Nat6LRm8AyMb7kwkywLkyEGF7ZZU4jQdcbN3eLg5UiOvRlmsD
	 ozmr2HyebIIezE6k1Zw6iOZUKGdBbl4rKcq1Lg4CuSxu0cn57hTOoPAvuEZodCTDyqXlc
	 eezYCCpQLnqmo8IajI//+ECKA8tWGEblUYyoTJn1r9WWkhsYQnqG2IutYur966X0TSuwX
	 kJd13n5cbapUuEXCqW4xprIcjXRLY2yGNZ8j/nydhQQb59q9+ClSf7mLWTEZprfhHjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949970;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5/yQ0dk5eP9GlrS5wHtd0duPzfvTTFtKKsxQEo2RnNM=;
	b=hjT3RBiYlNUorcdiByo/wnYNfnNiRHmF9r5i0QPG9g8og2VS9eavu9iOicZ+ezbZejNn
	 y5Ifm74sWpZ3NsIWoPI2HmYz16Z2WB9wsnXxhBv3WrfXqDsfIqTdMvN2i93L7Zh5buWHU
	 Yw1G5612RpWTud5ST87MXprMpQ+rgzZIGV9PNOtUBkdLwGERHG69yU7jWRjk1nR9r6yNK
	 l4H4s6ofDYKtUiPj+iJlru/Atw8pJX5EjIuBYA+qFqQH69Td3JK05KLvgFUMnEPMKEZmu
	 IgVkrPvaOMnSlGAd8jIcH1beel8UWpYFRlMMsKhQY0dAI/M9GB0LSsRWALdUr3qOlYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="ExjJ4S/Y";
	arc=none smtp.remote-ip=79.135.106.97
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BE606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C9BE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=ExjJ4S/Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793949967; x=1794209167;
	bh=5/yQ0dk5eP9GlrS5wHtd0duPzfvTTFtKKsxQEo2RnNM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ExjJ4S/Yd7fWMknOuZGNjjjNh05DN6dwF97BNE/D8MNZjmybF+5PMWnPHmqcboTto
	 VE1jwMZfIhb+yfnrKTytrO8fGYCAHBLO+to1Ju54Ku+qwyNeCMpsWhvJnr/SXPbz5I
	 VBB+jsJJAa2p+CNBNgA0NdB8m0Dn8egVvRkhGr24Q2iEvQCKvNbyBEVDATpDSBHQU1
	 G18a7nTA602o4g3KQgllCHMutUWb8X/uZrytoZul6JSVzfVfmFtZSr2Nwk216Emp7t
	 HJfp2aZ13pr3owO5KF7c5GpQ9GytImsNu7QsMhMZinDZrHiOT5HGkQ773bmD36YA65
	 5fdDjPeX2eC3Q==
Date: Fri, 06 Nov 2026 07:26:02 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Notes on configuring Sophos XG 135 firewall as a Wireless LAN Controller
Message-ID: <910Jl7etfNHwKSHH1rF-hbbLJc-38crHzkThkt8kV1wscPK5xa3speoCnAvXwikxN6H_eaZO1ogpj14PNvGw-1CW3T53WPuE-YoqVnRsnOE=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: f54c6b0f3e1d4e5831ad81a11b640636fa27be4e
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Notes on configuring Sophos XG 135 firewall as a Wireless LAN Cont=
roller

Good day from Singapore,

Author: Mr. Turritopsis Dohrnii Teo En Ming
Date: 6 Nov 2026 Friday 2.53 pm
Country: Singapore

I will guide you through configuring your Sophos XG 135 firewall from facto=
ry defaults, using your TP-Link Archer NX500 (192.168.26.1) as the internet=
 gateway.

Our objective is to use the Sophos XG 135 as a wireless controller and DHCP=
 server for your three Sophos APX 530 access points, without NAT or routing=
 client internet traffic through the Sophos firewall.

1. Final network design

IP addressing plan

Device=09IP address
TP-Link Archer NX500:=09192.168.26.1
Sophos XG 135:=09192.168.26.2
Subnet mask:=09255.255.255.0
Default gateway:=09192.168.26.1
DHCP pool:=09192.168.26.100=E2=80=93199
DHCP Option 234:=09192.168.26.2

The Sophos will distribute DHCP addresses, but wireless clients will use th=
e TP-Link router directly for internet access.

Important: Factory resetting the XG 135 erases its existing configuration. =
Back up anything important first, and perform this during a maintenance win=
dow.

2. Factory-reset the Sophos XG 135

Do this with the Sophos XG 135 disconnected from your production LAN.
1. Connect a monitor and keyboard to the Sophos XG 135, or use its console =
port with the appropriate cable.
2. Power on the firewall.
3. Log in to the console.
4. Open the device-management/reset menu and choose the factory-reset optio=
n.
5. Confirm that you want to erase the existing configuration.
6. Wait for the firewall to restart.
The exact reset-menu sequence varies by installed SFOS version. Do not sele=
ct firmware recovery or reinstallation unless necessary.

3. Connect your laptop to the Sophos XG 135

Initially, use a direct Ethernet connection:

Set a temporary static IPv4 address on your Windows laptop:

Setting=09Value
IP address:=09172.16.16.2
Subnet mask:=09255.255.255.0
Default gateway:=09Leave blank
DNS:=09Leave blank

Open:

https://172.16.16.16:4444

On the Sophos XG 135 Rev. 3, Sophos documents Port 1 as the default managem=
ent interface, with the default credentials admin / admin. Newer firmware m=
ay require an immediate password change.

4. Complete the initial setup wizard

After logging in:
1. Set a strong administrator password.
2. Select the correct timezone: Asia/Singapore (UTC+8).
3. Configure DNS and the device hostname.
4. Complete any registration or licensing steps required by the installed f=
irmware.
5. Skip optional security services that you do not intend to use, where the=
 wizard permits.
6. Finish the setup and log in to the main administration interface.
Because your Sophos XG 135 will not be your internet gateway, you do not ne=
ed to enable NAT or configure a production WAN connection.

Do not connect the Sophos XG 135 to the PoE switch yet. First configure its=
 management IP address.

5. Change the Sophos XG 135 LAN IP address

Navigate to Network =E2=86=92 Interfaces.

Edit the LAN interface, normally Port 1, and configure:

Setting=09Value
Name:=09LAN
Zone:=09LAN
IPv4 configuration:=09Static
IP address:=09192.168.26.2
Netmask:=09/24
Gateway:=09Not configured on the interface

Save the changes.

Your browser will disconnect because the firewall's IP address has changed.

Change your laptop's temporary address to:
- IP: 192.168.26.10
- Subnet mask: 255.255.255.0

Reconnect at:

https://192.168.26.2:4444

Then configure the XG 135's default route under Routing =E2=86=92 Static Ro=
utes:
- Destination: 0.0.0.0/0
- Gateway: 192.168.26.1
- Interface: LAN

On some SFOS versions, a default route via a LAN interface may need to be c=
onfigured as a gateway under Routing =E2=86=92 Gateways instead. Verify tha=
t the Sophos XG 135 can reach 192.168.26.1 and the internet before proceedi=
ng.

6. Configure DHCP on the Sophos XG 135

Navigate to Network =E2=86=92 DHCP =E2=86=92 Server =E2=86=92 Add.

Configure:

Setting=09Value
Name:=09LAN_DHCP
Interface:=09Port 1 / LAN
Dynamic IP lease:=09192.168.26.100=E2=80=93192.168.26.199
Subnet mask:=09255.255.255.0
Gateway:=09192.168.26.1
DNS 1:=09192.168.26.1
DNS 2:=091.1.1.1
Lease time:=091440 minutes

Very important: Enter 192.168.26.1 as the DHCP gateway. Do not select Use i=
nterface IP as gateway, because that would make clients use the Sophos XG 1=
35 instead of the tp-link Archer NX500.

Sophos supports specifying a gateway other than the DHCP server's own inter=
face IP.=20

Save the DHCP configuration, but leave the tp-link Archer NX500 DHCP servic=
e running until you are ready for the cutover.

7. Configure DHCP Option 234

This is the important setting for Sophos APX 530 discovery.

Under the DHCP server's DHCP Options / Custom Options section, create:

Setting=09Value
Option code:=09234
Type:=09IP address
Value:=09192.168.26.2

Bind the option to the LAN_DHCP server and save.

Sophos confirms that Option 234 directs AP registration requests to the fir=
ewall IP instead of the default discovery address 1.2.3.4.

8. Enable Sophos Wireless Protection

Navigate to Wireless =E2=86=92 Wireless Settings.
1. Enable Wireless Protection.
2. Under Allowed Zones, select LAN.
3. Click Apply.
4. Under Administration =E2=86=92 Device Access, ensure the appropriate LAN=
 management and wireless services are permitted, if that option is availabl=
e in your firmware.

Sophos documents LAN as a supported zone for AP registration.

9. Connect the Sophos XG 135 to your PoE switch

Once its interface and DHCP settings are ready:
1. Connect the Sophos XG 135 Port 1 to a regular Ethernet port on the PoE s=
witch.
2. Connect a tp-link Archer NX500 LAN port to the same switch.
3. Disable DHCP on the tp-link Archer NX500.
4. Ensure the Sophos DHCP server is running.
5. Change your laptop back to automatic IP addressing.
6. Reconnect your laptop to the LAN and renew its DHCP lease.

10. Connect and register your three Sophos APX 530 access points

Connect each Sophos APX 530 to an adequately powered PoE+ port.

On the Sophos XG 135:

1. Go to Wireless =E2=86=92 Access Points.
2. Wait for the APs to receive DHCP addresses and discover the firewall.
3. Look under Pending Access Points.
4. Check the serial numbers against the labels on your APs.
5. Click Accept for each one.
6. Wait until they show as Active.

Sophos uses TCP port 2712 for AP management.=20

If the APs do not appear, check that Option 234 is being supplied in their =
DHCP leases and that they can reach 192.168.26.2 on TCP 2712.

11. Create the Wi-Fi network

Go to Wireless =E2=86=92 Wireless Networks =E2=86=92 Add.

Setting=09Recommended configuration
Name:=09Office_WiFi
SSID:=09Office-WiFi
Security mode:=09WPA2-Personal
Encryption:=09AES
Password:=09Strong unique password
Client traffic:=09Bridge to AP LAN
Frequency bands:=092.4 GHz and 5 GHz

Save, then go to Wireless =E2=86=92 Access Points and assign Office_WiFi to=
 all three Sophos APX 530s.

Do not create a separate bridge interface on the Sophos XG 135. Sophos spec=
ifically confirms that external APX access points using Bridge to AP LAN do=
 not require a firewall bridge interface.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Republic of Singapore
6 Nov 2026 Friday 3.11 pm Singapore Time




