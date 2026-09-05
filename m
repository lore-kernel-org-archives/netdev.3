Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E84E80CD
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788635578; cv=pass; b=FfP6U60hLKRVkgYWWPaYwtTBc4V8J1x6R59d6ayzhEy0k0LMh49xollRt1GUZjqkSMqLt1+madOVDnBswzp2uQdmnowDIynLczHPQeZaKWwAot3XGdVF71Y98t7q+QkpOoNE4YrSEkYzV8ygF0L9LKs/Pk66POxRxOkEmgltBH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788635578; c=relaxed/simple;
	bh=VD96xYBneCzYveibSi9DkOz1XdxHUds2s2SOChJSVvk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DToItJF9SvDrtEKE86hFnd9EbEmaodb4Jg+qxOUKhKfhKld5rwIMNbN7aN/RtLa/gVgEhVh7SgTiREXcG0oOiMuZT1dMDhTb3iXljMVMh+GqrI3+ckhPpCk3/HCBnCCCACjozx2/OpkqAKZojjcg1yvzVrFYWUUQQ10Pf6krbIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU1GJUld; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU1GJUld"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66f8053e7afso1481845d50.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 12:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788635575; cv=none;
        d=google.com; s=arc-20260327;
        b=DrsJnlvW5IPDT/nEBWtnAACT4M9v1YvU2tc5QDyA06FaJhH0B28t6PLVWTXoM2j0Z4
         oX4iRS5/OxcLyP5aNjmRC+b3cX2kHlI9lES5IaTkevrd4T5p14b57xj0xtjIZiP/R4+P
         gfINd+/NH32J+a5neLIgIex5xwS3sIU6JrQPiy9i8DNzcRBHLQvy6fmNz0UCKQwhAMPh
         TkbG88qrD9Fk3I+8/FVa2+180B5KmGsYGNC+NqWNM0vX2fJKJef4U6fvumEqL/L9lS0o
         QY/0uKLn4mHf17GgrQTTi1tz68eIO0B52NweCOdVIseqfUzZjCAPQg1QVvuI1q8AcWS+
         VYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PTaf4U17AGF2GVtM/YYvZOfRsBC5Y+i2r2rctGpFmxA=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=VN71gSIFYMAQ6IggY/A6D8zk61BHHiy/BDHyFr4iYxS2bQZIx4vIV3p5tQ3efCyg7+
         B5U0qtYw9PJEKjomaDguSd+Y1re3cc0vW16sr7DCXe986G+vlyC/9W+HymZAGZcm91xw
         qq6tnrjf+QThDVeelrPLejmr8oi5a0ISyceaF3wvHdPO5UZ1dApPaWLQlBixs7V789GC
         ZsEcMuw/KjnKEMrZTZ64Tger7RyfyeVfRNzufttGytJC1X0uM5h9Ro3BkqLB2l1HRnLy
         EghWunX4epzCg/KaapHleJLyZ7xmIb9CV1A/MGlzCBM8VaLf8nJNIsRb3m93gVkZDIZl
         mong==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788635575; x=1789240375; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PTaf4U17AGF2GVtM/YYvZOfRsBC5Y+i2r2rctGpFmxA=;
        b=aU1GJUldKYrE8QEirnnJBRcboPqdgeIPB5fu/eRiqdYi7HBfSdQzQc6vENi1L9q7Nz
         AX86fEgc2ayF/nUoDlR7d0KqJgXEkRqGIA76HVtNTtFUL4JGgaq3L74+Pj2VWvr7prS4
         DJbVqpKw+SVj+UaEmoguF+9WJhpxjLjWTMNjekElyhe7nvePvMkGjgaWn0lubcPhgWg9
         YWMbDSxZnG7PbmRx57ugCB77bg5N8GVakrdKv+nVg6fjiixS0mVZDjr0qgXOug+9jhw1
         w2X8l6giAuQ5i9dPCgRoqPG675p+P8xrd7ngm75e3kdbFKlvWbplx+6gDL3sIyzkZbY6
         QUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788635575; x=1789240375;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PTaf4U17AGF2GVtM/YYvZOfRsBC5Y+i2r2rctGpFmxA=;
        b=jVE+J2nACOdZiq8xX+zbLDDwvJp1AFAjyYtAAJksO5jngisT88GqZ1+OMz4bNhHrnI
         6StVjEtuv83Mr2D6yMdPTDlP40JKhGvAQwidnV4htQzOT/kCoT6QIg/fjX9qbW5v/eSg
         ugiWzSJZlMWLLHQV+G7438wJ1AygeLh+npXWpVdXmvGWKMC5vHrCzsIPQjVZtWpvdrnQ
         YmUBjEdprHlcMQRPXK4zEt95D/Eg30Qlcj+nWSSrNuhSwRkOJOHMSaL+eFbYIwMoRznz
         MQOq/WFt0wggPajV57kZdJbHOK1nxQRjdfEll+LcW5Vhq5SvqiOmEgMH1/4cCNNZzNyv
         TV5g==
X-Gm-Message-State: AFuF++kgkfGSs1Xt3tSiwurT2enmlNkAas4ygN7wy9zjuI1U6jWxVf8t
	WjqIqwIVqnSjAOSkGfAelBn+BT2q3dp8h7g+VVFUK8pn8Lo83v8Wr5VoaUL91fWtBnudSv9uKAR
	58RbPvBoKXY51GzgwEJIvheE0uIcrHWaSKyr+
X-Gm-Gg: AYBFou1NANthqBwVC3dVipn6ax0WSH3La8VVN0tF1OI4A6+AC3Q6prI+1gsgiGu4+Ij
	7fJI7eqlUIyU+wseZ1hsEN5arXo0cMUSAAL5PYKZ2UCwci0KPS9ZzQKIrb31pL599h+c8GAsr+7
	JjdaDZVoC+/XMydr7flqupqNA8ianwySdWm1807Un/PCmVDjKdPDAIOghpcCk8Na3XPraMQgbAx
	U66CU6DkFV0YheQbIsoIFlIEcQcQo3nylrwQLVb9612kRx3ZQeEZ7TAW3G4w/oeMesAo95k+HQX
	84Hr6PDjZqmsnKTzjBv/J+Pk3B0y/ShOkNaHyeyxzphJaQ1wU+XgXB7NN09zfShcgR89F1cUhZq
	tZx4=
X-Received: by 2002:a05:690e:4805:b0:66c:a3e8:be00 with SMTP id
 956f58d0204a3-66fb6c36e78mr3077669d50.45.1788635574928; Sat, 05 Sep 2026
 12:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roshan Vijey <emailroshanvijey@gmail.com>
Date: Sun, 6 Sep 2026 00:42:44 +0530
X-Gm-Features: AcwNN1WrTcEgNR2seHi_7DMklBwzEeYADJsFgqM_IpgNrelCAc_kv-m0NMbZ18o
Message-ID: <CAPtxZmoiOyYKqpom-hQGgFa15TMWwySTQELFQW1AmcJZV9o+nA@mail.gmail.com>
Subject: AF_PACKET + PACKET_FANOUT_LB: why does the observed round-robin
 sequence break after some time?
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am currently learning about packet-capturing techniques on Linux and
experimenting with AF_PACKET sockets and PACKET_FANOUT specifically
PAKCET_FANOUT_LB.

I created a test program with 4 AF_PACKET sockets, all bound to the
same network interface and belonging to the same fanout group.

Each socket is handled by its own capture thread.

The architecture is:

            Network Interface
                   |
                   v
          AF_PACKET fanout
          PACKET_FANOUT_LB
                   |
      +-------------+---------------------------+
      |             |             |             |
      v             v             v             v
   Socket 0      Socket 1      Socket 2      Socket 3
      |             |             |             |
      v             v             v             v
   Thread 0      Thread 1      Thread 2      Thread 3
      |             |             |             |
      v             v             v             v
   Queue 0       Queue 1       Queue 2       Queue 3
      |             |             |             |
      +-------------+-------------+-------------+
                    |
                    v
             Collector thread


Each capture thread reads packets from its socket, makes a heap copy
of the packet, and pushes the copied packet into its own queue. A
single collector thread then consumes packets from the four queues.

For debugging, the collector prints information such as:

Pkt No , Src IP , Dest IP , Src port , Dest port , Protocol , TCP Seq
No , TCP Ack No

I looked at the Linux kernel source code in net/packet/af_packet.c,
specifically fanout_demux_lb(). The relevant code in the kernel source
I am testing is:

static unsigned int fanout_demux_lb(struct packet_fanout *f,
struct sk_buff *skb,
unsigned int num)
{
unsigned int val = atomic_inc_return(&f->rr_cur);

return val % num;


}

Since I have 4 sockets, my understanding is that if rr_cur starts at
0, the sequence would be: 1,2,3,0,1,2,3,0...

Therefore, I expected the sockets selected by the load-balancing
algorithm to follow:

Socket 1 Socket 2 Socket 3 Socket 0 Socket 1 Socket 2 Socket 3 Socket 0 ...

At the beginning of the test, the packet sequence observed by my
application followed the expected pattern very well. I also captured
the same traffic using Wireshark and compared the packets using the
TCP sequence and acknowledgement numbers. The application log and
Wireshark capture appeared to correspond correctly. I have attached
screenshots showing the initial behavior.

However, after approximately one hour of continuous execution, the
round-robin pattern observed by my application starts to break.

For example, after packet number 214510, the round robin sequence no
longer appears to follow

I have attached screenshots showing the application log and the
corresponding Wireshark capture at the point where this happens.

I repeated the same test again, and the same type of behavior
occurred, so it does not appear to be a one-time occurrence.

The interesting part is that the problem does not happen immediately.
The application can run for a long time while the expected pattern is
observed, and then the observed sequence starts to differ.

#include "Logger.h"

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <netinet/udp.h>
#include <sys/socket.h>
#include <unistd.h>

#include
#include <condition_variable>
#include
#include
#include
#include
#include
#include
#include

static const int CAPTURE_THREADS = 4;
static const int START_QUEUE = 1;
static const int SNAPSHOT_LENGTH = 65536;
static const int READ_TIMEOUT_MS = 1000;
static const int KERNEL_BUFFER_SIZE = 256 * 1024 * 1024;
static const char* INTERFACE_NAME = "wlp2s0";
static uint16_t fanoutID = static_cast<uint16_t>(getpid());

struct CapturedPacket {
std::vector<uint8_t> data;
uint64_t packetNumber;
};

struct CollectorQueue {
std::queue packets;
std::mutex mutex;
std::condition_variable condition;
};

static std::vector captureSockets(CAPTURE_THREADS, -1);
static std::vectorstd::thread captureThreads;
static std::vector collectorQueues(CAPTURE_THREADS);
static std::thread collectorThread;

static std::atomic stopPacketCapture(false);
static std::atomic<uint64_t> packetNumber(0);

bool setPromiscuousMode(int socketFd, const char* interfaceName) {
struct packet_mreq mreq{};

mreq.mr_ifindex = static_cast<int>(if_nametoindex(interfaceName));
mreq.mr_type = PACKET_MR_PROMISC;
if (setsockopt(socketFd, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
               &mreq, sizeof(mreq)) < 0) {
    return false;
}

return true;


}

void setKernelBuffer(int socketFd) {
int bufferSize = KERNEL_BUFFER_SIZE;

if (setsockopt(socketFd, SOL_SOCKET, SO_RCVBUFFORCE, &bufferSize,
sizeof(bufferSize)) < 0) {
    LOG("CAPTURE", "Failed to set kernel buffer to 256 MB");
}


}

bool setReadTimeout(int socketFd) {
struct timeval timeout{};

timeout.tv_sec = READ_TIMEOUT_MS / 1000;
timeout.tv_usec = (READ_TIMEOUT_MS % 1000) * 1000;

if (setsockopt(socketFd, SOL_SOCKET, SO_RCVTIMEO,&timeout,
sizeof(timeout)) < 0) {
    return false;
}

return true;


}

int createSocket(const char* interfaceName, int threadID) {
int socketFd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
if (socketFd < 0) {
LOG("CAPTURE " + std::to_string(threadID), "Failed to create socket");
return -1;
}

int interfaceIndex = static_cast<int>(if_nametoindex(interfaceName));

if (interfaceIndex == 0) {
    LOG("CAPTURE " + std::to_string(threadID),"Failed to get interface index");
    close(socketFd);
    return -1;
}

struct sockaddr_ll address{};

address.sll_family = AF_PACKET;
address.sll_protocol = htons(ETH_P_ALL);
address.sll_ifindex = interfaceIndex;

if (bind(socketFd, reinterpret_cast<struct
sockaddr*>(&address),sizeof(address)) < 0) {
    LOG("CAPTURE " + std::to_string(threadID),"Failed to bind socket");
    close(socketFd);
    return -1;
}

if (!setPromiscuousMode(socketFd, interfaceName)) {
    LOG("CAPTURE " + std::to_string(threadID),"Failed to enable
promiscuous mode");
    close(socketFd);
    return -1;
}

setKernelBuffer(socketFd);

if (!setReadTimeout(socketFd)) {
    LOG("CAPTURE " + std::to_string(threadID),"Failed to set read timeout");
    close(socketFd);
    return -1;
}

return socketFd;


}

bool joinFanoutGroup(int socketFd) {
uint32_t group = (static_cast<uint32_t>(PACKET_FANOUT_LB) << 16) | fanoutID;
if (setsockopt(socketFd, SOL_PACKET, PACKET_FANOUT, &group,
sizeof(group)) < 0) {
return false;
}

return true;


}

void parsePacket(const CapturedPacket& packet, int threadID) {
std::string threadName = "CAPTURE " + std::to_string(threadID);

if (packet.data.size() < sizeof(struct ethhdr)) {
    LOG(threadName,"[Non IP] Pkt No : ", packet.packetNumber);
    return;
}

const struct ethhdr* ethernet =
    reinterpret_cast<const struct ethhdr*>(packet.data.data());

if (ntohs(ethernet->h_proto) != ETH_P_IP) {
    LOG(threadName,"[Non IP] Pkt No : ", packet.packetNumber);
    return;
}

if (packet.data.size() <
    sizeof(struct ethhdr) + sizeof(struct ip)) {
    LOG(threadName,"[Non IP] Pkt No : ", packet.packetNumber);
    return;
}
const struct ip* ipHeader = reinterpret_cast<const struct
ip*>(packet.data.data() + sizeof(struct ethhdr));

char srcIP[INET_ADDRSTRLEN];
char dstIP[INET_ADDRSTRLEN];

inet_ntop(AF_INET, &ipHeader->ip_src,srcIP, sizeof(srcIP));

inet_ntop(AF_INET, &ipHeader->ip_dst,dstIP, sizeof(dstIP));

const unsigned char* transportHeader = packet.data.data() +
sizeof(struct ethhdr) + (ipHeader->ip_hl * 4);

if (ipHeader->ip_p == IPPROTO_TCP) {
    if (packet.data.size() < sizeof(struct ethhdr) + (ipHeader->ip_hl
* 4) + sizeof(struct tcphdr)) {
        return;
    }

    const struct tcphdr* tcp = reinterpret_cast<const struct
tcphdr*>(transportHeader);

    LOG(threadName,
        "[TCP] Pkt No : ", packet.packetNumber,
        " Src IP : ", srcIP,
        " Dst IP : ", dstIP,
        " Src Port : ", ntohs(tcp->source),
        " Dst Port : ", ntohs(tcp->dest),
        " Seq No : ", ntohl(tcp->seq),
        " Ack No : ", ntohl(tcp->ack_seq));

    return;
}

if (ipHeader->ip_p == IPPROTO_UDP) {
    if (packet.data.size() < sizeof(struct ethhdr) + (ipHeader->ip_hl
* 4) + sizeof(struct udphdr)) {
        return;
    }

    const struct udphdr* udp = reinterpret_cast<const struct
udphdr*>(transportHeader);
    LOG(threadName,
        "[UDP] Pkt No : ", packet.packetNumber,
        " Src IP : ", srcIP,
        " Dst IP : ", dstIP,
        " Src Port : ", ntohs(tcp->source),
        " Dst Port : ", ntohs(tcp->dest));

    return;
}

LOG(threadName,"[Non IP] Pkt No : ", packet.packetNumber);


}

void capturePacketOnBlockingMode(int socketFd, int threadID) {
uint8_t* buffer = new uint8_t[SNAPSHOT_LENGTH];
std::string threadName = "CAPTURE " + std::to_string(threadID);

LOG(threadName,"Draining the Pre-Started Packets");

while (recv(socketFd, buffer, SNAPSHOT_LENGTH,MSG_DONTWAIT) > 0) {
}

if (stopPacketCapture.load()) {
    LOG(threadName,"Stop packet capture is set to true, stopping
capture thread");
    delete[] buffer;
    return;
}

LOG(threadName,"Started Capturing Packets");
while (!stopPacketCapture.load()) {
    ssize_t received = recv(socketFd, buffer, SNAPSHOT_LENGTH, 0);

    if (received < 0) {
        if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR) {
            continue;
        }

        if (!stopPacketCapture.load()) {
            LOG(threadName,"recv failed");
        }

        continue;
    }

    if (received == 0)
        continue;

    CapturedPacket packet;

    packet.packetNumber = ++packetNumber;

    packet.data.assign(buffer,buffer + received);

    CollectorQueue& queue = collectorQueues[threadID];

    {
        std::lock_guard<std::mutex> lock(queue.mutex);
        queue.packets.push(std::move(packet));
    }

    queue.condition.notify_one();
}
LOG(threadName,"Capture thread stopped");

delete[] buffer;


}

void collectPackets() {
int queueIndex = START_QUEUE;

LOG("COLLECTOR","Collector thread started");

while (!stopPacketCapture.load()) {
    CollectorQueue& queue = collectorQueues[queueIndex];

    std::unique_lock<std::mutex> lock(queue.mutex);

    queue.condition.wait(lock, [&queue] {
        return !queue.packets.empty() ||
               stopPacketCapture.load();
    });

    if (stopPacketCapture.load())
        break;

    CapturedPacket packet =
        std::move(queue.packets.front());

    queue.packets.pop();

    lock.unlock();

    parsePacket(packet, queueIndex);

    queueIndex =
        (queueIndex + 1) % CAPTURE_THREADS;
}

LOG("COLLECTOR","Collector thread stopped");


}

void startThreads() {

for(int i = 0; i < CAPTURE_THREADS; ++i){
    if (!joinFanoutGroup(captureSockets[i])) {
        LOG("CAPTURE " + std::to_string(i),"Failed to join fanout group");
        stopPacketCapture = true;
        return;
    }
}

for (int i = 0; i < CAPTURE_THREADS; ++i) {
    captureThreads.emplace_back(capturePacketOnBlockingMode,captureSockets[i],i);
}
collectorThread =std::thread(collectPackets);


}

void startAFPacketCapture(const char* interfaceName) {
for (int i = 0; i < CAPTURE_THREADS; ++i) {
captureSockets[i] = createSocket(interfaceName, i);

    if (captureSockets[i] < 0) {
        stopPacketCapture = true;
        return;
    }
}

startThreads();

return;


}

void stopThreads() {
stopPacketCapture = true;
for (int i = 0; i < CAPTURE_THREADS; ++i)
collectorQueues[i].condition.notify_all();

for (int socketFd : captureSockets) {
    if (socketFd >= 0)
        shutdown(socketFd, SHUT_RDWR);
}

for (std::thread& thread : captureThreads) {
    if (thread.joinable())
        thread.join();
}

if (collectorThread.joinable())
    collectorThread.join();

for (int& socketFd : captureSockets) {
    if (socketFd >= 0) {
        close(socketFd);
        socketFd = -1;
    }
}

logger.stop();


}

int main() {

logger.start();

startAFPacketCapture(INTERFACE_NAME);

while (!stopPacketCapture.load())
    std::this_thread::sleep_for(std::chrono::seconds(1));

stopThreads();

return 0;


}

Figure 1: Application log at the beginning of packet capture.

Figure 2: Corresponding Wireshark packet capture.

Figure 3: Application log after packet 214510, where the expected
round-robin sequence breaks.

Figure 4: Corresponding Wireshark capture showing the same packets.

(You can find those figures in
https://unix.stackexchange.com/questions/807293/af-packet-packet-fanout-lb-why-does-the-observed-round-robin-sequence-break-a)

So , my questions are

Does PACKET_FANOUT_LB guarantee strict round-robin assignment? , If
not please give explanation.

My actual requirement is to distribute packets from a single interface
among multiple processing threads using a round-robin scheme. I would
still like to use AF_PACKET. If PACKET_FANOUT_LB does not provide a
guarantee that is sufficient for this requirement, is there another
recommended way to achieve consistent round-robin distribution while
continuing to use AF_PACKET?
Also , if you think there is some issue in my code which makes the
round robin fail please correct me.

Thanks,
Roshan
