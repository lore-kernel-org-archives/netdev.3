Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF503DA5DC
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653313; cv=none; b=SeoEbvpzLdL57iuPexGegoHusZMqR60oMZ7h6ZzoMOqqZDFSj5VT1Y65uISn50MyTB4LQbdgMvI2BNPAs/aOr3X+GfWxTLtdf4ScTvKg6HSkNwVyXsEft83EvKnjs9Hs0egoWLXImuwi6QY+PpoLZ4UthLf+Y24K+0w8JEJXeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653313; c=relaxed/simple;
	bh=sd8FdrlgIj4k+JN42x1/AYfG2xFFyGj5w/xQanSsFV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhouRtamZehs+zx0Tf4ELYSHHKkaTQOnzQYyCwErkmdnThA2dTaQpL6c7rK2LEhsnyiN9RG7kNmgBiyNbp/cJU+kd4LipwWqeDn8VyUK0iV3wNO/iRFcYallTARakiMJmXcXkZOoj9rAmPjN2Hox7G9oNAz4PPNPZBVd5CFCM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev; spf=pass smtp.mailfrom=q-lab.dev; dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b=8W339XFf; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=9ctI/jik; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=q-lab.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=q-lab.dev header.i=@q-lab.dev header.b="8W339XFf";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="9ctI/jik"
DKIM-Signature: a=rsa-sha256; b=8W339XFfyT9SFEY3Sc5sviYn0vReELruMLixJvSJMKpMcGRP8m3mQ5nBMFyugscrShj/h14wABzkkSCTCwO0Rs/jI9XZfhf/iVuYbL2do33URSqS2nyNo11niZgDvf7KBssl25CfTA/Mds4FdvHy5/SJJoLKMKepDPtRqaAyY+I08P5jDe/GdKaom2CpLfG8Wsc1stfoc1iaBZIcEm47dtEn/SwqU6vtn5jl8T1IXCrTcnh2kFGqNiRJzu/C7Uxkq4VDwJCFfraW0pm47q5qanDYPXR4vcrQWEEN0CHcAXQnnRm2AsrQS1jRn2+pFLelCZeRqNkhvVVQfTqnRmf8kg==; s=purelymail3; d=q-lab.dev; v=1; bh=sd8FdrlgIj4k+JN42x1/AYfG2xFFyGj5w/xQanSsFV8=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=9ctI/jik4yDNFoHtDukzsQjJYyhlGqcnCUcAjtaBcITojg+5tL41x4PwJtHbEzJKHAFTCyl5PjW6oYP2CdM3IhEEEr8reo/YjZG6RVmfunONzUKmpAVwMVZBLVhTm07JLJSH83r5VaVJaCtrhrqktXGdS3xtq5Mlz4m8ymmFcmJGCU+Fif/6Z5xajm4TAK1C3gGDkwJlTexmzjser/xXHsXJhmca0+q5GpYpS9z3hCpDy15xUvIMlieDFYxyZI4O1M/RnJPQSXJZryS/ovVBsWHXB8kEV2LmtqN0RW/LVKYk4SlnvPY9wdQabVpVF8OEOmq9gFhO16cPbFxvqCZeyw==; s=purelymail3; d=purelymail.com; v=1; bh=sd8FdrlgIj4k+JN42x1/AYfG2xFFyGj5w/xQanSsFV8=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 284201:25281:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 898957456;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 29 Sep 2026 03:41:40 +0000 (UTC)
Message-ID: <4e1ef527-e843-4f1b-9f7f-cf2400fa443e@q-lab.dev>
Date: Mon, 28 Sep 2026 20:41:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sparx5: start the domain 0 TOD counter on
 non-PTP lan969x variants
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Richard Cochran <richardcochran@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260928044955.29647-1-quentin@q-lab.dev>
 <20260928151453.fzch356vrp3ergy7@DEN-DL-M70577>
Content-Language: en-US
From: Quentin Freimanis <quentin@q-lab.dev>
In-Reply-To: <20260928151453.fzch356vrp3ergy7@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel, thanks for taking the time to reply.

On 9/28/26 8:14 AM, Daniel Machon wrote:
> Hi Quentin,
> 
>> Currently the base non-PTP capable lan969x variants don't forward any
>> ethernet frames. Testing showed that starting the domain 0 TOD counter
>> gets them working again.
> 
> Ack. Not initializing the TOD domains on certain variants is a problem.
> 
> However, TOD domains shouldn't affect basic forwarding. I tried it on my board
> with PTP forced off - no forwarding issues.
> 
> Certain TSN features do require TOD domains to be configured, though. How did
> you test this, and what exactly did you see fail?

Here is my test setup:

- a LAN9698-V/3KW purchased on digikey in October 2025.

- My SoM dtsi [1], board dts [2], schematics of the som [3] and 
schematics of the carrier board [4].

- net/main commit a7bfaba4823e

- a minimal buildroot initramfs [5]

- eth10 in the test log is a 1g RGMII port connected to a RTL8211F PHY.

Note: I've snipped the output of some commands to save space.

Without this patch, right after a reboot:

     $ cat /proc/cmdline
     console=ttyAT0,115200 earlycon
     systemd.mask=systemd-networkd.service
     systemd.mask=systemd-networkd.socket

     $ uname -a
     Linux buildroot 7.3.0-rc4 #11 SMP PREEMPT Mon Sep 28 19:14:03 PDT 
2026 aarch64 GNU/Linux

     $ ip link set eth10 up

     $ ip addr add 10.0.0.45/24 dev eth10

     $ ping 10.0.0.1
     PING 10.0.0.1 (10.0.0.1): 56 data bytes
     --- 10.0.0.1 ping statistics ---
     9 packets transmitted, 0 packets received, 100% packet loss

     $ cat /proc/interrupts
                 CPU0
     20:          0  GIC-0  120 Level     sparx5-fdma

     $ ip -s link
     12: eth10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq 
state UP mode DEFAULT group default qlen 1000
         link/ether 4e:b7:8e:61:37:1e brd ff:ff:ff:ff:ff:ff
         RX:  bytes packets errors dropped  missed   mcast
             53745     278      0       0       0     174
         TX:  bytes packets errors dropped carrier collsns
                 0       0      0       0       0       0
         altname enx4eb78e61371e

After a fresh boot with this patch:

     $ cat /proc/cmdline
     console=ttyAT0,115200 earlycon 
systemd.mask=systemd-networkd.service systemd.mask=systemd-networkd.socket

     $ uname -a
     Linux buildroot 7.3.0-rc4 #10 SMP PREEMPT Sun Sep 27 21:23:12 PDT 
2026 aarch64 GNU/Linux

     $ ip link set eth10 up

     $ ip addr add 10.0.0.45/24 dev eth10

     $ ping 10.0.0.1
     PING 10.0.0.1 (10.0.0.1): 56 data bytes
     64 bytes from 10.0.0.1: seq=0 ttl=64 time=1.927 ms
     64 bytes from 10.0.0.1: seq=1 ttl=64 time=0.876 ms
     64 bytes from 10.0.0.1: seq=2 ttl=64 time=0.832 ms
     --- 10.0.0.1 ping statistics ---
     3 packets transmitted, 3 packets received, 0% packet loss
     round-trip min/avg/max = 0.832/1.211/1.927 ms

     $ cat /proc/interrupts
                 CPU0
     20:       2039  GIC-0  120 Level     sparx5-fdma

     $ ip -s link

     12: eth10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq 
state UP mode DEFAULT group default qlen 1000
         link/ether a2:ef:53:a5:06:73 brd ff:ff:ff:ff:ff:ff
         RX:  bytes packets errors dropped  missed   mcast
             147075    1646      0      96       0      61
         TX:  bytes packets errors dropped carrier collsns
             75918     957      0       0       0       0


> 
>>
>> Fix by moving the TOD counter start code into a helper and calling it in
>> sparx5_ptp_init(). Non-PTP capable lan969x parts now start the domain 0
>> counter, and PTP-capable parts start all three, as they used to. A similar
>> workaround that starts all three and registers the PHC clocks is
>> implemented in the vendor BSP 6.18 kernel [1].
> 
> What we do downstream, is to ensure that all domains and PHC's are configured
> and registered on all variants, with a very simple is_sparx5() check.

My reasoning for only enabling the first counter and not registering the 
clocks is that the part does not have SPX5_FEATURE_PTP, so it should not 
expose any PTP features to userspace.

> 
>>
>> [1] https://github.com/microchip-ung/linux/tree/bsp-6.18-2026
>>
>> Fixes: 207966787b71 ("net: sparx5: add feature support")
>> Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>
>> ---
>> If anyone with access to documentation more detailed than the
>> register map knows WHY this clock needs to be running, I'd like to add
>> that to the commit message.
> 
> 
>>
>>   .../ethernet/microchip/sparx5/sparx5_ptp.c    | 72 +++++++++++++------
>>   1 file changed, 49 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
>> index 5953e04ef14e..b436684ddae6 100644
>> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
>> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
>> @@ -573,6 +573,42 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>>          return 0;
>>   }
>>
>> +static int sparx5_ptp_tod_start(struct sparx5 *sparx5, u8 phc_mask)
>> +{
>> +       u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
>> +       int i;
>> +
>> +       if (phc_mask > GENMASK(SPARX5_PHC_COUNT - 1, 0))
>> +               return -EINVAL;
>> +
>> +       /* Disable master counters */
>> +       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
>> +
>> +       /* Configure the nominal TOD increment per clock cycle */
>> +       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(phc_mask),
>> +                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
>> +                sparx5, PTP_PTP_DOM_CFG);
>> +
>> +       for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
>> +               if (!(phc_mask & BIT(i)))
>> +                       continue;
>> +
>> +               spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
>> +                       PTP_CLK_PER_CFG(i, 0));
>> +               spx5_wr((u32)(tod_adj >> 32), sparx5,
>> +                       PTP_CLK_PER_CFG(i, 1));
>> +       }
>> +
>> +       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
>> +                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
>> +                sparx5, PTP_PTP_DOM_CFG);
>> +
>> +       /* Enable master counters */
>> +       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(phc_mask), sparx5, PTP_PTP_DOM_CFG);
>> +
>> +       return 0;
>> +}
>> +
>>   static struct ptp_clock_info sparx5_ptp_clock_info = {
>>          .owner          = THIS_MODULE,
>>          .name           = "sparx5 ptp",
>> @@ -605,7 +641,6 @@ static int sparx5_ptp_phc_init(struct sparx5 *sparx5,
>>
>>   int sparx5_ptp_init(struct sparx5 *sparx5)
>>   {
>> -       u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
>>          const struct sparx5_ops *ops = sparx5->data->ops;
>>          struct sparx5_port *port;
>>          int err, i;
>> @@ -622,8 +657,17 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
>>                  sparx5->ptp = 1;
>>          }
>>
>> -       if (!sparx5->ptp)
>> +       if (!sparx5->ptp) {
>> +               if (!is_sparx5(sparx5)) {
>> +                       /* the base, non-ptp-capable lan969x variants need the first tod counter
> 
> Nit: s/the/The
> 
>> +                        * running to forward frames.
>> +                        */
>> +                       err = sparx5_ptp_tod_start(sparx5, BIT(0));
>> +                       if (err)
>> +                               return err;
>> +               }
>>                  return 0;
>> +       }
>>
>>          for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
>>                  err = sparx5_ptp_phc_init(sparx5, i, &sparx5_ptp_clock_info);
>> @@ -635,27 +679,9 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
>>          spin_lock_init(&sparx5->ptp_ts_id_lock);
>>          mutex_init(&sparx5->ptp_lock);
>>
>> -       /* Disable master counters */
>> -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
>> -
>> -       /* Configure the nominal TOD increment per clock cycle */
>> -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0x7),
>> -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
>> -                sparx5, PTP_PTP_DOM_CFG);
>> -
>> -       for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
>> -               spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
>> -                       PTP_CLK_PER_CFG(i, 0));
>> -               spx5_wr((u32)(tod_adj >> 32), sparx5,
>> -                       PTP_CLK_PER_CFG(i, 1));
>> -       }
>> -
>> -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
>> -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
>> -                sparx5, PTP_PTP_DOM_CFG);
>> -
>> -       /* Enable master counters */
>> -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
>> +       err = sparx5_ptp_tod_start(sparx5, GENMASK(SPARX5_PHC_COUNT - 1, 0));
>> +       if (err)
>> +               return err;
>>
>>          for (i = 0; i < sparx5->data->consts->n_ports; i++) {
>>                  port = sparx5->ports[i];
>> --
>> 2.55.0
>>
>>
> 
> /Daniel

[1] 
https://gitlab.com/qfreiman/buildroot-external-qlab/-/blob/master/board/qlab/openswitch-lan969x/dts/microchip/lan9698-openswitch.dtsi
[2] 
https://gitlab.com/qfreiman/buildroot-external-qlab/-/blob/master/board/qlab/openswitch-lan969x/dts/microchip/lan9698-openswitch-10x10g.dts
[3] 
https://gitlab.com/qfreiman/openswitch-lan969x/-/blob/master/openswitch-lan969x.pdf
[4] 
https://gitlab.com/qfreiman/openswitch-10x10g-carrier/-/blob/master/openswitch-10x10g-carrier.pdf
[5] 
https://gitlab.com/qfreiman/buildroot-external-qlab/-/blob/master/configs/qlab_openswitch_lan969x_defconfig

- Quentin

